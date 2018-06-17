class CreateDrugs < ActiveRecord::Migration[5.2]
  def change
    create_table :drugs do |t|
      t.string :id_drug
      t.string :registered_name
      t.string :active_ingredient
      t.string :pharmaceutical_form
      t.string :insurance_list
      t.string :issuing
      t.string :atc
      t.string :license_holder

      t.timestamps
    end
  end
end
