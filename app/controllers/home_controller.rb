class HomeController < ApplicationController
  skip_before_action :verify_ip_address
  caches_page :index, :info, :help
  def index
  end

  def info
  end

  def help
  end
end
