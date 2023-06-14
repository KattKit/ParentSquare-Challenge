class CreateAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :admins, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :username, null: false, default: ""
      t.uuid :api_key, null: false, default: "gen_random_uuid()"


      t.timestamps
    end

    add_index :admins, :username, unique: true
    add_index :admins, :api_key, unique: true

  end
end


