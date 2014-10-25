class AddPicToPersonals < ActiveRecord::Migration
  def change
    add_column :personals, :pic, :string
  end
end
