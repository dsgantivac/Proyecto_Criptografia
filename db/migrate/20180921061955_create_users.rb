class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, index: { unique: true }
      t.string :password
      t.string :conf_password
      t.string :name

      t.timestamps
    end
  end
end
