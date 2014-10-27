class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :email
      t.timestamp :request_time
      t.text :message
      t.string :restaurant

      t.timestamps
    end
  end
end
