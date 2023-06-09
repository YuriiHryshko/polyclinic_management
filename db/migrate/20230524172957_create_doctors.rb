class CreateDoctors < ActiveRecord::Migration[7.0]
  def change
    create_table :doctors do |t|

      t.timestamps
    end
    create_table :doctors_categories, id: false do |t|
      t.belongs_to :doctor
      t.belongs_to :category
    end
  end
end
