class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :message_status, null: false, default: ""
      t.string :remote_id, default: ""
      t.belongs_to :phone_number, null: false, type: :uuid
      t.string :body, null: false

      t.timestamps
    end

    add_index :messages, :remote_id, unique: true
  end
end

