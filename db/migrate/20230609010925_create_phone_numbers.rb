class CreatePhoneNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :phone_numbers, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :number_status,      null: false, default: ""
      t.string :phone_number,       null: false, default: ""

      t.timestamps
    end

    add_index :phone_numbers, :phone_number, unique: true
  end
end
