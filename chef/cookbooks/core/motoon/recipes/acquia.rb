directory "/var/www/site-php" do
  owner "vagrant"
  group "vagrant"
end

if node["vdd"]["sites"]

  node["vdd"]["sites"].each do |index, site|
    sitename = index

    # Create subidrectores, allow for multiple layers deep.
    htdocs = "/var/www/site-php/" + sitename
    directory htdocs do
      owner "vagrant"
      group "vagrant"
      mode "0755"
      action :create
    end

    template htdocs + '/' + sitename + '-settings.inc' do
      source "acquia_sql.inc.erb"
      mode "0644"
      variables ({:dbname => sitename})
    end
  end
end
