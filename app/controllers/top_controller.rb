class TopController < ApplicationController
  def index
    @posts = Timeline.all
  end
end
