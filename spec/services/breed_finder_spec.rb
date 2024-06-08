require 'rails_helper'

RSpec.describe BreedFinder, type: :service do
  subject(:breed_finder) { described_class.new(url:, adapter:) }

  let(:url) { 'url' }
  let(:adapter) { double(:adapter, get: data) }
  let(:data) do
    {
      links: { next: 'next_url' },
      data: [
        {},
        attributes: {
          name: 'Mutt',
          description: 'A happy dog',
          life: {
            min: 1,
            max: 15
          },
          male_weight: {
            min: 0,
            max: 500
          },
          female_weight: {
            min: 0,
            max: 500
          },
          hypoallergenic: true
        }
      ]
    }
  end

  describe '#next_page' do
    it 'returns the next page' do
      expect(breed_finder.next_page).to eq('next_url')
    end

    context 'when the next page is missing' do
      let(:data) { {} }

      it 'returns nil' do
        expect(breed_finder.next_page).to be_nil
      end
    end
  end

  describe '#find' do
    let(:result) do
      {
        name: 'Mutt',
        description: 'A happy dog',
        life_min: 1,
        life_max: 15,
        male_weight_min: 0,
        male_weight_max: 500,
        female_weight_min: 0,
        female_weight_max: 500,
        hypoallergenic: true
      }
    end

    it 'returns the breeds' do
      expect(breed_finder.find).to eq([result])
    end

    context 'when the data is empty' do
      let(:data) { {} }

      it 'returns empty' do
        expect(breed_finder.find).to eq([])
      end
    end

    context 'when the attributes is empty' do
      let(:data) { { data: [{}] } }

      it 'returns empty' do
        expect(breed_finder.find).to eq([])
      end
    end

    context 'when attributes is missing' do
      let(:data) { { data: [{ attributes: { name: 'test' } }] } }
      let(:result) do
        {
          name: 'test',
          description: nil,
          life_min: nil,
          life_max: nil,
          male_weight_min: nil,
          male_weight_max: nil,
          female_weight_min: nil,
          female_weight_max: nil,
          hypoallergenic: false
        }
      end

      it 'returns the breeds' do
        expect(breed_finder.find).to eq([result])
      end
    end
  end
end
