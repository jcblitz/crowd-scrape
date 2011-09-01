module VariablesModule
  DROPDOWNS = []
  # Add an instance of DropdownEntry for every "Directory" you want to search in crowd. For example:
  # DROPDOWNS << DropdownEntry.new("New York Office", 1)
  # This is saying select the 1st dropdown position and call it "New York Office"
  # Create an entry for each directory you want to search. The first field is a display label when showing results and the second numeric field is the position in the dropdown menu. Do not forget 0 is actually the first entry.
  DROPDOWNS << DropdownEntry.new("GSI", 5)
  DROPDOWNS << DropdownEntry.new("ISH", 6)
  DROPDOWNS << DropdownEntry.new("SysIQ", 9)

  #This is the base url for your crowd installation. Something like http://crowd.mycompany.com
  BASE_URL = "http://crowd.tools.us.gspt.net"
end
