# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

def breed_sync(url)
  BreedSynchronizer.synchronize(url:) do |next_page|
    breed_sync(next_page)
  end
end

breed_sync("#{ENV['DOGAPI_URL']}/breeds")

Owner.create!(name: 'John Doe')

Pet.create!(name: 'Fido', breed: Breed.first, owner: Owner.first)
Pet.create!(name: 'Rex', breed: Breed.last, owner: Owner.first)
