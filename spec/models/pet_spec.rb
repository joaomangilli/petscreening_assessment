require 'rails_helper'

RSpec.describe Pet do
  subject(:pet) { create(:pet) }

  it { expect(pet).to validate_presence_of(:name) }
  it { expect(pet).to validate_numericality_of(:weight).is_greater_than(0).allow_nil }

  it { expect(pet).to belong_to(:breed) }
  it { expect(pet).to belong_to(:owner).optional }
end
