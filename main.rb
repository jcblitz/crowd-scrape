require 'sinatra'
require 'mechanize'
require File.join(File.dirname(__FILE__), 'navi')


ACCOUNT = "blitzsteinj:Katie1980"
get '/' do
  agent = Mechanize.new
  #page = agent.get('http://crowd.tools.us.gspt.net/crowd/console/login.action')
  #login_form = page.form("login")
  #login_form.j_username = j_username
  #login_form.j_password = j_password

  #login_result = agent.submit(login_form, login_form.buttons.first)

  if (params[:username] == nil || params[:username].empty?)
    @user_tables = []
  else
    ln = LoginNav.new(agent)
    r = ln.login
    s = ln.search("#{params[:username]}")
    @user_tables = ln.parse_users(s)
  end


  erb :index 

end
