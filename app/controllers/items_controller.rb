class ItemsController < ApplicationController
  def index
    @user = User.new
  end
end
