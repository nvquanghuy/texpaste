class AddViewsToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :views, :integer, :default => 0
  end
end
