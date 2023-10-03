require 'rails_helper'

RSpec.describe User, type: :model do
  it 'validates presence of email' do
    user = User.new(email: nil)
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'validates uniqueness of email' do
    FactoryBot.create(:user, email: 'existing@example.com')
    user = User.new(email: 'existing@example.com')
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include('has already been taken')
  end

  it 'validates presence and minimum length of password' do
    user = User.new(password: nil)
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include("can't be blank")

    user = User.new(password: '12345')
    expect(user).not_to be_valid
    expect(user.errors[:password]).to include('is too short (minimum is 8 characters)')
  end

  describe '#reset_pin!' do
    it 'resets the pin to a random 4-digit number' do
      user = FactoryBot.create(:user)
      original_pin = user.pin

      user.reset_pin!

      expect(user.pin).not_to eq(original_pin)
      expect(user.pin).to be >= 1000
      expect(user.pin).to be <= 9999
    end
  end

  describe '#unverify!' do
    it 'sets the verified attribute to false' do
      user = FactoryBot.create(:user, verified: true)
      user.unverify!

      expect(user.verified).to eq(false)
    end
  end

  describe '#send_pin!' do
    it 'calls reset_pin! and unverify! methods' do
      user = FactoryBot.create(:user)
      allow(user).to receive(:reset_pin!).and_call_original
      allow(user).to receive(:unverify!).and_call_original

      user.send_pin!

      expect(user).to have_received(:unverify!).once
    end

    it 'calls SendPinJob.perform_now' do
      user = FactoryBot.create(:user)
      allow(SendPinJob).to receive(:perform_now).and_call_original

      user.send_pin!

      expect(SendPinJob).to have_received(:perform_now).with(user)
    end
  end
end
