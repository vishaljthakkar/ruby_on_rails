class CreateHobbiesPeople < ActiveRecord::Migration[5.2]
  def change
    # id: false and index added manually
    create_table :hobbies_people, id: false do |t|
      t.references :person, index: true, foreign_key: true
      t.references :hobby, index: true, foreign_key: true
    end
  end
end
