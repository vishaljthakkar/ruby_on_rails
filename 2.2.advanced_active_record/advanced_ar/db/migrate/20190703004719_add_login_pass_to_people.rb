class AddLoginPassToPeople < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :login, :string
    add_column :people, :pass, :string
  end
end
