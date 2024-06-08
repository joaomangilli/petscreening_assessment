class BreedSynchronizerJob < ApplicationJob
  sidekiq_options retry: 3, queue: :breed_sync, retry_queue: :retry_breed_sync

  def perform(url)
    BreedSynchronizer.synchronize(url:) do |next_page|
      BreedSynchronizerJob.perform_later(next_page)
    end
  end
end
