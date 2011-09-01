class DropdownEntry
  attr_accessor :name, :dropdown_index, :table_data

  def initialize(name, dropdown_index)
    @name = name
    @dropdown_index = dropdown_index
  end

end

class MechSteps 
  attr_accessor :agent, :dropdown_entries
  J_USERNAME = ENV["LDAP_USERNAME"] 
  J_PASSWORD = ENV["LDAP_PASSWORD"]
  BASE_URL = "http://crowd.tools.us.gspt.net"

  #Keep the two arrays inline, the first is the actual position in the dropdown to select the directory, the second is for displaying it on the front end. I'll move this to an object if it gets any more complicated.
  DIRECTORIES = [5, 6 ,9]
  DIRECTORY_NAMES = ["GSI", "ISH", "SysIQ"]

  def initialize(agent, dropdown_entries)
    @agent = agent
    @dropdown_entries = dropdown_entries
  end

  def login
    page = self.agent.get("#{BASE_URL}/crowd/console/login.action")
    login_form = page.form("login")
    login_form.j_username = J_USERNAME
    login_form.j_password = J_PASSWORD

    login_result = self.agent.submit(login_form, login_form.buttons.first)
  end


  def search(term)
    results = []

    self.dropdown_entries.each do |dropdown_entry|
      results << search_each(term, dropdown_entry)
    end
    results
  end
  
  def parse_users(results)
    results.each_with_index do |result, i|
      table = scrape_for_content(result)
      self.dropdown_entries[i].table_data = table
    end
    return self.dropdown_entries 
  end

  def scrape_for_content(result)
    table = result.search("#user-details").first
    return table 
  end

  def search_each(term, dropdown_entry)
    page = self.agent.get("#{BASE_URL}/crowd/console/secure/user/browse.action")
    search_form = page.form("searchusers")
    search_form.search = term
    search_form.field_with(:name => 'directoryID').options[dropdown_entry.dropdown_index].select
    search_form_result = self.agent.submit(search_form, search_form.buttons.first)
    return search_form_result 
  end
end
