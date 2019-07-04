class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :company
      t.string :position_id
      #index: true is added manually and was not added by rails generate
      t.references :person, index: true, foreign_key: true

      #null: false added manually
      t.timestamps null:false
    end
  end
end
