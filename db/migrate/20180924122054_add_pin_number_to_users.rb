class AddPinNumberToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pin, :string
  end
end
