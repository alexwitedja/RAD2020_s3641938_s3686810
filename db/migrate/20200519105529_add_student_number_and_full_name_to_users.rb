class AddStudentNumberAndFullNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :student_number, :string
    add_column :users, :full_name, :string
  end
end
