require 'rails_helper'

RSpec.describe GraphqlController do
  describe 'POST /graphql' do
    def trigger
      post :execute, params:
    end

    let(:params) { { query: gql_query } }

    context 'with malformed query' do
      let(:gql_query) { '{a}' }
      let(:expected_response) { { errors: [ hash_including(message: /Field 'a' doesn't exist on type 'Query'/) ] } }

      it do
        trigger
        expect(response).to match_controller_status(200, match(expected_response))
      end
    end

    context 'with well-formed query' do
      let(:gql_query) { '{ menu(state:null) { id } }' }
      let(:expected_response) do
        {
          data: {
            menu: array_including(
              { id: /\d+/ }
            )
          }
        }
      end

      context 'when menus exist' do
        before { Menu.create!() } # TODO: switch to fabricator

        it 'returns list of ids' do
          trigger
          expect(response).to match_controller_status(200, match(expected_response))
        end
      end

      context 'when menus with different state exist' do
        before do
          Menu.create!(state: :active)
          Menu.create!(state: :inactive)
        end

        context 'with state matching query' do
          let(:gql_query) { '{ menu(state:active) { id state } }' }
          let(:expected_response) do
            {
              data: {
                menu: array_including(
                  { id: /\d+/, state: 'active' }
                )
              }
            }
          end

          it 'returns list of ids' do
            trigger
            expect(response).to match_controller_status(200, match(expected_response))
          end
        end

        context 'with no states matching query' do
          let(:gql_query) { '{ menu(state:unapproved) { id } }' }
          let(:expected_response) do
            {
              data: {
                menu: []
              }
            }
          end

          it 'returns empty list' do
            trigger
            expect(response).to match_controller_status(200, match(expected_response))
          end
        end
      end
    end
  end
end
