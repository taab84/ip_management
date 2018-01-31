class HomeController < ApplicationController
  caches_page :index, :info, :help
  def index
  end

  def info
  end

  def help
  end
end
