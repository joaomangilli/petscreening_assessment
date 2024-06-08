require 'rails_helper'

RSpec.describe OwnersController, type: :request do
  let(:headers) do
    { 'Accept' => 'application/json' }
  end

  let(:json_body) do
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:owner) { create(:owner, name: 'John Doe') }

  describe 'GET /owners' do
    before do
      owner

      get '/owners', headers:
    end

    it 'is successful' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the owners' do
      expect(json_body.first).to include(
        name: 'John Doe'
      )
    end
  end

  describe 'GET /owners/:id' do
    before do
      get "/owners/#{owner.id}", headers:
    end

    it 'is successful' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the owner' do
      expect(json_body).to include(
        name: 'John Doe'
      )
    end
  end

  describe 'POST /owners' do
    subject(:post_owner) { post '/owners', params:, headers: }

    context 'when params are valid' do
      let(:params) { { owner: { name: 'John Doe' } } }

      it 'is successful' do
        post_owner

        expect(response).to have_http_status(:created)
      end

      it 'creates a new owner' do
        expect { post_owner }.to change { Owner.count }.by(1)
      end
    end

    context 'when params are invalid' do
      let(:params) { { owner: { name: nil } } }

      it 'is unsuccessful' do
        post_owner

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new owner' do
        expect { post_owner }.not_to(change { Owner.count })
      end

      it 'tells what is wrong' do
        post_owner

        expect(json_body).to include(
          name: ["can't be blank"]
        )
      end
    end
  end

  describe 'PUT /owners' do
    before do
      put "/owners/#{owner.id}", params:, headers:
    end

    context 'when params are valid' do
      let(:params) { { owner: { name: 'test' } } }

      it 'is successful' do
        expect(response).to have_http_status(:success)
      end

      it 'updates the owner' do
        expect(owner.reload.name).to eq('test')
      end
    end

    context 'when params are invalid' do
      let(:params) { { owner: { name: nil } } }

      it 'is unsuccessful' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the owner' do
        expect(owner.reload.name).to eq('John Doe')
      end

      it 'tells what is wrong' do
        expect(json_body).to include(
          name: ["can't be blank"]
        )
      end
    end
  end

  describe 'DELETE /owners/:id' do
    subject(:delete_owner) { delete "/owners/#{owner.id}", headers: }

    it 'is successful' do
      delete_owner

      expect(response).to have_http_status(:success)
    end

    context 'when the owner has pets' do
      before do
        create(:pet, owner:)
      end

      it 'is unsuccessful' do
        delete_owner

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not delete the owner' do
        expect { delete_owner }.not_to change { Owner.count }
      end

      it 'tells what is wrong' do
        delete_owner

        expect(json_body).to include(
          base: ["Cannot delete record because dependent pets exist"]
        )
      end
    end
  end
end
