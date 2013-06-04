class CreateAriReadFiles < ActiveRecord::Migration
  def self.up
    create_table :ari_read_files do |t|
      t.string :name
      t.boolean :data_read

      t.timestamps
    end
  end

  def self.down
    drop_table :ari_read_files
  end
end