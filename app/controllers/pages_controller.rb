class PagesController < ApplicationController
  include HighVoltage::StaticPage
  layout :determine_layout

  private
  def determine_layout
    if request.headers['X-PJAX']
      false
    else
      'application'
    end
  end

end
