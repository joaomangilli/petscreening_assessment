require 'rails_helper'

RSpec.describe BreedSynchronizer, type: :service do
  subject(:breed_synchronizer) { described_class.new(url:, finder:) }

  let(:url) { 'url' }
  let(:finder) { double(:finder, next_page:, find:) }
  let(:next_page) { 'next_page' }
  let(:find) do
    [
      {
        name: SecureRandom.hex,
        description: 'A happy dog',
        life_min: 1,
        life_max: 15,
        male_weight_min: 0,
        male_weight_max: 500,
        female_weight_min: 0,
        female_weight_max: 500,
        hypoallergenic: true
      }
    ]
  end

  describe '#synchronize' do
    it 'creates the breeds' do
      expect { breed_synchronizer.synchronize }.to change { Breed.count }.by(1)
    end

    it 'calls the block' do
      expect(BreedSynchronizerJob).to receive(:perform_later).with(next_page)

      breed_synchronizer.synchronize do |next_page|
        BreedSynchronizerJob.perform_later(next_page)
      end
    end

    context 'when next page is empty' do
      let(:next_page) { nil }

      it 'does not call the block' do
        expect(BreedSynchronizerJob).not_to receive(:perform_later)

        breed_synchronizer.synchronize do |next_page|
          BreedSynchronizerJob.perform_later(next_page)
        end
      end
    end
  end
end
