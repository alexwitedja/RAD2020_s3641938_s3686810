class AddCityInfoToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :city, :string
    add_column :users, :info, :string
  end
end
