module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    # class_attribute :slug_column
  end

  def generate_slug
    # case self
    #   when Post
    #     slug_base = self.title
    #   when User
    #     slug_base = self.username
    #   when Category
    #     slug_base = self.name
    # end
    slug_base = self.username
    
    s = slug_base.gsub(' ', '-').downcase
    s.gsub!(/[^a-zA-Z0-9-]/,'')
    i = 1;
    base_string = s
    while self.class.exists?(slug: s) and !((self.class.where(slug: s).size == 1) and (self.class.find_by(slug: s).id == self.id)) do
      s = base_string + i.to_s
      i += 1
    end
    self.slug = s
  end


  def to_param
    self.slug
  end


end