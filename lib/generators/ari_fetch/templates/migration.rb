class CreateAriFiles < ActiveRecord::Migration
  def self.up
    create_table :ari_files do |t|
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :ari_files
  end
end