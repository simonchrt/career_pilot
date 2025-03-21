class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.string :status
      t.references :user, null: false, foreign_key: true
      t.references :job_listing, null: false, foreign_key: true
      t.date :applied_date
      t.date :response_date
      t.date :interview_date
      t.text :notes
      t.integer :priority

      t.timestamps
    end
  end
end
