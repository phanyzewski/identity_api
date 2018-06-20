class CreateStateIdentifiers < ActiveRecord::Migration[5.2]
  def change
    create_table :state_identifiers do |t|
      t.string :state_id_number, null: false
      t.string :state, null: false
      t.date :expiration_date, null: false
      t.string :image_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
