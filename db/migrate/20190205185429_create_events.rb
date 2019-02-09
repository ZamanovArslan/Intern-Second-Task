class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :name_of_event, null: false
      t.string :regularity, null: false
      t.date :date_event, null: false
      t.timestamp :start_of_event, null: true
      t.timestamp :end_of_event, null: true
      t.timestamps
    end
    add_reference :events, :user, foreign_key: true
  end
end
