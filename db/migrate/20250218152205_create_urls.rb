class CreateUrls < ActiveRecord::Migration[7.2]
  def change
    create_table :urls do |t|
      t.string :short_url, index: true
      t.string :long_url, null: false
      t.timestamps
    end

    add_index :urls, :long_url, unique: true
  end
end
