require 'rails_helper'

RSpec.describe Breed do
  subject(:breed) { create(:breed) }

  it { expect(breed).to validate_presence_of(:name) }
  it { expect(breed).to validate_presence_of(:description) }
  it { expect(breed).to validate_presence_of(:life_min) }
  it { expect(breed).to validate_presence_of(:life_max) }
  it { expect(breed).to validate_presence_of(:male_weight_min) }
  it { expect(breed).to validate_presence_of(:male_weight_max) }
  it { expect(breed).to validate_presence_of(:female_weight_min) }
  it { expect(breed).to validate_presence_of(:female_weight_max) }

  it { expect(breed).to validate_uniqueness_of(:name) }

  it { expect(breed).to have_many(:pets).dependent(:restrict_with_error) }
end
