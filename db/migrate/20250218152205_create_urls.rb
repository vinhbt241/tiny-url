class CreateUrls < ActiveRecord::Migration[7.2]
  def change
    create_table :urls do |t|
      t.string :identifier, null: false
      t.string :long_url, null: false
      t.timestamps
    end

    add_index :urls, :identifier, unique: true
    add_index :urls, :long_url, unique: true
  end
end
