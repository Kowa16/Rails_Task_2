class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :profile_name
      t.string :self_introduction

      t.timestamps
    end
  end
end
