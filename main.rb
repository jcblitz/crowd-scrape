require 'sinatra'
require 'mechanize'
require File.join(File.dirname(__FILE__), 'navi')

get '/' do
  agent = Mechanize.new

  if (params[:username] == nil || params[:username].empty?)
    @user_tables = []
  else
    ln = LoginNav.new(agent)
    perform_login_results = ln.login
    perform_search_results = ln.search("#{params[:username]}")
    @user_tables = ln.parse_users(perform_search_results)
  end
  erb :index 
end
