require 'rails_helper'

RSpec.describe Article, type: :model do

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:slug) }
  end
end