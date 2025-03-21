class CreateApplicationSteps < ActiveRecord::Migration[7.1]
  def change
    create_table :application_steps do |t|
      t.references :application, null: false, foreign_key: true
      t.string :step_type
      t.datetime :date
      t.text :notes
      t.boolean :completed
      t.date :next_action_date

      t.timestamps
    end
  end
end
