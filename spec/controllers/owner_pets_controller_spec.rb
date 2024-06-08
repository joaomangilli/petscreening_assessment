require 'rails_helper'

RSpec.describe PetsController, type: :request do
  let(:headers) do
    { 'Accept' => 'application/json' }
  end

  let(:json_body) do
    JSON.parse(response.body, symbolize_names: true)
  end

  before do
    create_list(:pet, 5)
  end

  let(:pet) { create(:pet, name: 'Dog') }
  let(:owner) { pet.owner }

  describe 'GET /owners/:id/pets' do
    before do
      pet

      get "/owners/#{owner.id}/pets", headers:
    end

    it 'is successful' do
      expect(response).to have_http_status(:success)
    end

    it "returns the owner's pets" do
      expect(json_body.first).to include(
        name: 'Dog'
      )
    end
  end

  describe 'GET /owners/:id/pets/:id' do
    before do
      get "/owners/#{owner.id}/pets/#{pet.id}", headers:
    end

    it 'is successful' do
      expect(response).to have_http_status(:success)
    end

    it "returns the owner's pet" do
      expect(json_body).to include(
        name: 'Dog'
      )
    end
  end

  describe 'PUT /owners/:id/pets/:id' do
    before do
      put "/owners/#{owner.id}/pets/#{pet.id}", params:, headers:
    end

    let(:owner) { create(:owner) }
    let(:pet) { create(:pet, owner: nil) }
    let(:params) { { pet: { name: 'bla' } } }

    it 'is successful' do
      expect(response).to have_http_status(:success)
    end

    it 'associates the pet with the owner' do
      expect(pet.reload.owner_id).to eq(owner.id)
    end
  end
end
