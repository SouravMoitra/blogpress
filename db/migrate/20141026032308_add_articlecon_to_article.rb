class AddArticleconToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :articlecon, :string
  end
end
