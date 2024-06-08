require 'rails_helper'

RSpec.describe BreedSynchronizerJob, type: :job do
  subject(:breed_synchronizer_job) { BreedSynchronizerJob.new }

  let(:url) { 'url' }
  let(:next_page) { 'next_page' }

  describe '#perform' do
    it 'calls the synchronizer' do
      expect(BreedSynchronizer).to receive(:synchronize).with(url:)

      breed_synchronizer_job.perform(url)
    end

    it 'calls the block' do
      allow(BreedSynchronizer).to receive(:synchronize).with(url:).and_yield(next_page)
      expect(BreedSynchronizerJob).to receive(:perform_later).with(next_page)

      breed_synchronizer_job.perform(url)
    end
  end
end
