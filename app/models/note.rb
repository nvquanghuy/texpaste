class Note < ActiveRecord::Base
  attr_accessible :content, :title, :slug
  before_create :generate_slug

protected
  def generate_slug
  	self.slug = rand(36**8).to_s(36) if self.new_record?
  end
end
