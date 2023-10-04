require 'rails_helper'

RSpec.describe PushNotification, type: :model do
  it 'is valid with valid attributes' do
    push_notification = PushNotification.new(
      title: 'Test Title',
      body: 'Test Body'
    )
    expect(push_notification).to be_valid
  end

  it 'is not valid without a title' do
    push_notification = PushNotification.new(
      title: nil,
      body: 'Test Body'
    )
    expect(push_notification).not_to be_valid
  end

  it 'is not valid without a body' do
    push_notification = PushNotification.new(
      title: 'Test Title',
      body: nil
    )
    expect(push_notification).not_to be_valid
  end
end
