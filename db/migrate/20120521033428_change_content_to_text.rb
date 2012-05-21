class ChangeContentToText < ActiveRecord::Migration
  def up
    change_column :notes, :content, :text
  end

  def down
  end
end
