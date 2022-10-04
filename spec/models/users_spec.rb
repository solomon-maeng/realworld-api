require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do
    it { should have_many(:articles).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
  end

  describe 'uniqueness of email' do
    let!(:user) { create(:user) }

    it { should validate_uniqueness_of(:email).case_insensitive }
  end
end