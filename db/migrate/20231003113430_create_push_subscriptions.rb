class CreatePushSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :push_subscriptions do |t|
      t.string :endpoint
      t.string :p256dh
      t.string :auth
      t.boolean :subscribed

      t.timestamps
    end
  end
end
