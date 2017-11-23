require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it { is_expected.to have_many(:tasks).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('eduardo@gmail.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email, created_at and a token' do
      allow(Devise).to receive(:friendly_token).and_return('abc1234yxhRIHOHF')
      user.save!
      expect(user.info).to eq("#{user.email} - #{user.created_at} - #{Devise.friendly_token}")
    end
  end

  describe '#generate_authentication_token!' do
    it 'generates a unique auth token' do
      allow(Devise).to receive(:friendly_token).and_return('abc1234yxhRIHOHF')
      user.generate_authentication_token!
      expect(user.auth_token).to eql('abc1234yxhRIHOHF')
    end

    it 'generates another auth token when the current auth token already has been taken' do
      allow(Devise).to receive(:friendly_token).and_return('abc1234tokenxyz', 'abc1234tokenxyz', 'abcXYZ123456789')
      existing_user = create(:user)
      user.generate_authentication_token!
      expect(user.auth_token).not_to eq(existing_user.auth_token)
    end
  end
end
