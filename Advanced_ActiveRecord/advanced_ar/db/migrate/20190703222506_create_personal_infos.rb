class CreatePersonalInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :personal_infos do |t|
      t.float :height
      t.float :weight
      #index: true is added manually and was not added by rails generate
      t.references :person, index: true , foreign_key: true

      # null: false added manually
      t.timestamps null:false
    end
  end
end
