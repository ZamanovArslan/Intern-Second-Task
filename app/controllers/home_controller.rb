class HomeController < ApplicationController
  before_action :authenticate_user!
  expose :event
end
