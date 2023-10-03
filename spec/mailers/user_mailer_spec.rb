require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'send_pin' do
    let(:user) { create(:user, email: 'user@example.com') }

    let(:mail) { UserMailer.send_pin(user) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Verification PIN Code')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'contains the verification PIN code' do
      expect(mail.body.encoded).to match(user.pin.to_s)
    end
  end
end
