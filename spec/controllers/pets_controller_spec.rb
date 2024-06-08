require 'rails_helper'

RSpec.describe PetsController, type: :request do
  let(:headers) do
    { 'Accept' => 'application/json' }
  end

  let(:json_body) do
    JSON.parse(response.body, symbolize_names: true)
  end

  let(:pet) { create(:pet, name: 'Dog') }

  describe 'GET /pets' do
    before do
      pet

      get '/pets', headers:
    end

    it 'is successful' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the pets' do
      expect(json_body.first).to include(
        name: 'Dog'
      )
    end
  end

  describe 'GET /pets/:id' do
    before do
      get "/pets/#{pet.id}", headers:
    end

    it 'is successful' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the pet' do
      expect(json_body).to include(
        name: 'Dog'
      )
    end
  end

  describe 'POST /pets' do
    subject(:post_pet) { post '/pets', params:, headers: }

    context 'when params are valid' do
      let(:breed) { create(:breed) }
      let(:params) { { pet: { name: 'Dog', breed_id: breed.id } } }

      it 'is successful' do
        post_pet

        expect(response).to have_http_status(:created)
      end

      it 'creates a new pet' do
        expect { post_pet }.to change { Pet.count }.by(1)
      end
    end

    context 'when params are invalid' do
      let(:params) { { pet: { name: nil } } }

      it 'is unsuccessful' do
        post_pet

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new pet' do
        expect { post_pet }.not_to(change { Pet.count })
      end

      it 'tells what is wrong' do
        post_pet

        expect(json_body).to include(
          name: ["can't be blank"]
        )
      end
    end
  end

  describe 'PUT /pets' do
    before do
      put "/pets/#{pet.id}", params:, headers:
    end

    context 'when params are valid' do
      let(:params) { { pet: { name: 'test' } } }

      it 'is successful' do
        expect(response).to have_http_status(:success)
      end

      it 'updates the pet' do
        expect(pet.reload.name).to eq('test')
      end
    end

    context 'when params are invalid' do
      let(:params) { { pet: { name: nil } } }

      it 'is unsuccessful' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the pet' do
        expect(pet.reload.name).to eq('Dog')
      end

      it 'tells what is wrong' do
        expect(json_body).to include(
          name: ["can't be blank"]
        )
      end
    end
  end

  describe 'DELETE /pets/:id' do
    subject(:delete_pet) { delete "/pets/#{pet.id}", headers: }

    it 'is successful' do
      delete_pet

      expect(response).to have_http_status(:success)
    end
  end
end
