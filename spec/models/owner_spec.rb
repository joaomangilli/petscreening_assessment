require 'rails_helper'

RSpec.describe Owner do
  subject(:owner) { create(:owner) }

  it { expect(owner).to validate_presence_of(:name) }
  it { expect(owner).to have_many(:pets).dependent(:restrict_with_error) }
end
