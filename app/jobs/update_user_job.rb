class UpdateUserJob < ActiveJob::Base
  def perform(user)
    return unless user.email.blank?

    user.update_column(:verified, true)
  end
end
