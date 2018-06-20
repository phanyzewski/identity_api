class CreateMedicalRecommendations < ActiveRecord::Migration[5.2]
  def change
    create_table :medical_recommendations do |t|
      t.integer :medical_recommendation_number, null: false
      t.string :issuer, null: false
      t.string :state, null: false
      t.date :expiration_date, null: false
      t.string :image_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
