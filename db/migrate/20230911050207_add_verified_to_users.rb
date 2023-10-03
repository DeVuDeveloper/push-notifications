class AddVerifiedToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pin, :integer
    add_column :users, :pin_sent_at, :datetime
    add_column :users, :verified, :boolean, default: false
  end
end
