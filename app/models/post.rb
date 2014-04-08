class Post < ActiveRecord::Base
  #attr_accessible :body, :title, :image

  has_attached_file :image,
    styles: { :thumb => "260x" }

  validates_presence_of :title,:body


  def summary
    body.split("READMORE").first
  end
end
