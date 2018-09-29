class AddEncryptTypeToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :encryptType, :string
  end
end
