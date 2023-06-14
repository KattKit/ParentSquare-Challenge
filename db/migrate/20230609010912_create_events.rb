class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.jsonb :data, default: {}
      t.string :tags, array: true, index: true, default: []
      t.timestamps
    end
  end
end
