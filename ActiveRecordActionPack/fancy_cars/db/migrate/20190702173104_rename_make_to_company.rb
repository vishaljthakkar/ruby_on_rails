class RenameMakeToCompany < ActiveRecord::Migration[5.2]
  def change
    # below line is added manually after running the following command on shell
    rename_column :cars,:make, :company
  end
end
