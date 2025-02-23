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
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).deep_symbolize_keys).to match(expected_response)
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
        before { Menu.create() } # TODO: switch to fabricator

        it 'returns list of ids' do
          trigger
          expect(response).to have_http_status(:success)
          expect(JSON.parse(response.body).deep_symbolize_keys).to match(expected_response)
        end
      end
    end
  end
end
