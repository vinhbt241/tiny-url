# frozen_string_literal: true

require 'swagger_helper'

describe 'Client Products APIs' do
  path '/encode' do
    post 'encode input URL into short URL' do
      tags 'Urls'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          url: { type: :string, example: 'https://example-input.com' }
        },
        required: ['url']
      }

      response '200', 'Url encoded' do
        let(:params) { { url: 'https://example-input.com' } }

        run_test!
      end

      response '422', 'Url is invalid' do
        let(:params) { { url: 'invalid-url' } }

        run_test!
      end
    end
  end

  path '/decode' do
    get 'return decoded URL from input short URL' do
      tags 'Urls'
      produces 'application/json'
      parameter name: :url, in: :query, type: :string, example: 'http://localhost:3000/iBx1qixjk'

      response '200', 'URL decoded' do
        let!(:record) { create(:url, url: 'https://example-input.com', identifier: IdentifierGenerator.generate_identifier) }
        let(:url) { "http://localhost:3000/#{record.identifier}" }

        run_test!
      end

      response '404', 'URL not found' do
        let(:url) { 'http://localhost:3000/nonexist' }

        run_test!
      end
    end
  end
end
