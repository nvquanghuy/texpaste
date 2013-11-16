class Note < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :title, :slug
  before_create :generate_slug

  def get_title
    title.present? ? title : "note:#{slug}"
  end

  protected
  def generate_slug
    self.slug = rand(36**8).to_s(36) if self.new_record?
  end
end
