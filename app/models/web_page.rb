class WebPage < ActiveRecord::Base

  belongs_to :website
  has_many :page_contents

  accepts_nested_attributes_for :page_contents, :allow_destroy => true

end