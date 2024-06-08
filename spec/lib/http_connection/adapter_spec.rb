require 'rails_helper'

RSpec.describe HttpConnection::Adapter, type: :adapters do
  describe '.get' do
    subject(:get) { described_class.get(url:) }

    let(:url) { 'url' }
    let(:response) { double(:response, body: body_response.to_json) }
    let(:body_response) { { age: 25 } }

    it 'returns the body response' do
      expect(Faraday).to receive(:get).with(url).and_return(response)

      expect(get).to eq(body_response.with_indifferent_access)
    end

    context 'when the request return an error' do
      it 'raises an HttpConnection::Adapter::Error' do
        expect(Faraday).to receive(:get).with(url).and_raise(Faraday::Error)

        expect { get }.to raise_error(HttpConnection::Adapter::Error)
      end
    end
  end
end
