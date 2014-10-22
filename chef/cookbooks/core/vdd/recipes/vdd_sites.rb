if node["vdd"]["sites"]
  include_recipe "database::mysql"

  node["vdd"]["sites"].each do |index, site|

    site["site_stages"].each do |stage|
      htdocs = index + '/' + stage + '/docroot'

      # Create subidrectores, allow for multiple layers deep.
      htdocs = "var/www/" + htdocs
      htdocs = htdocs.split(%r{\/\s*})
      folder = "/"
      for i in (0..htdocs.length - 1)
        folder = folder + htdocs[i] + "/"
        directory folder do
          owner "vagrant"
          group "vagrant"
          mode "0755"
          action :create
        end
      end

      mysql_connection_info = {
        :host => "localhost",
        :username => "root",
        :password => node["mysql"]["server_root_password"]
      }
      mysql_database index + '.' + stage do
        connection mysql_connection_info
        action :create
      end

    end
  end
end
