class ChangeCityInfoDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :city, "Mars"
    change_column_default :users, :info, "Your personal bio"
  end
end
