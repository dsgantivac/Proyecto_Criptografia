class ChangeBodyToBeStringInArticles < ActiveRecord::Migration[5.2]
  def change
    change_column :articles, :body, :string
  end
end
