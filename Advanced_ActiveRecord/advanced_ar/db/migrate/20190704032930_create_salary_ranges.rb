class CreateSalaryRanges < ActiveRecord::Migration[5.2]
  def change
    create_table :salary_ranges do |t|
      t.float :min_salary
      t.float :max_salary
      t.references :job, index: true, foreign_key: true

      t.timestamps
    end
  end
end
