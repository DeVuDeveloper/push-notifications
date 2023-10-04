require 'rails_helper'

RSpec.describe PushSubscription, type: :model do
  let(:valid_attributes) do
    {
      endpoint: 'https://example.com/endpoint',
      p256dh: 'sample_p256dh_key',
      auth: 'sample_auth_key',
      subscribed: true
    }
  end

  it 'is valid with valid attributes' do
    push_subscription = PushSubscription.new(valid_attributes)
    expect(push_subscription).to be_valid
  end

  it 'is not valid without an endpoint' do
    invalid_attributes = valid_attributes.merge(endpoint: nil)
    push_subscription = PushSubscription.new(invalid_attributes)
    expect(push_subscription).not_to be_valid
  end

  it 'is not valid without a p256dh key' do
    invalid_attributes = valid_attributes.merge(p256dh: nil)
    push_subscription = PushSubscription.new(invalid_attributes)
    expect(push_subscription).not_to be_valid
  end

  it 'is not valid without an auth key' do
    invalid_attributes = valid_attributes.merge(auth: nil)
    push_subscription = PushSubscription.new(invalid_attributes)
    expect(push_subscription).not_to be_valid
  end
end
