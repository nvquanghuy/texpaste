class AddIndexSlugInNote < ActiveRecord::Migration
  def up
  	add_index  :notes, :slug, :unique => true
  end

  def down
  	remove_index  :notes, :slug
  end
end
