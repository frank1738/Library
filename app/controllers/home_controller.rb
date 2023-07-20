class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]


  def index; end

  def borrow; end

  def reserve 
  end
end
