class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.references :follower, null: false
      t.references :user, null: false
      t.boolean :suscriber, default: false
      t.timestamps null: false
    end
  end
end
