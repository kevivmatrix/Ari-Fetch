class CreateAriReadFiles < ActiveRecord::Migration
  def self.up
    create_table :ari_read_files do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ari_read_files
  end
end