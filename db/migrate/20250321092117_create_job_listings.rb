class CreateJobListings < ActiveRecord::Migration[7.1]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.text :description
      t.string :url
      t.references :company, null: false, foreign_key: true
      t.boolean :remote
      t.integer :salary_min
      t.integer :salary_max
      t.string :currency
      t.string :contract_type

      t.timestamps
    end
  end
end
