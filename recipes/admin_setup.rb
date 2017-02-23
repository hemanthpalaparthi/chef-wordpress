template "/var/www/html/wp-admin/install.php" do
  source 'install.php.erb'
  mode '0644'
  variables(
    :website_title           => node['wordpress']['website']['title'],
    :admin_username           => node['wordpress']['admin']['username'],
    :admin_password       => node['wordpress']['admin']['password'],
    :admin_email           => node['wordpress']['admin']['email']
  )
  owner 'www-data'
  group 'www-data'
  action :create
end

template "/var/www/html/wp-config.php" do
  source 'wp-config.php.erb'
  mode '0644'
  variables(
    :db_name           => node['mysql']['database']['dbname'],
    :db_user           => node['mysql']['database']['new_user'],
    :db_password       => node['mysql']['database']['new_user_pwd'],
    :db_host           => node['mysql']['database']['host'],
	:db_charset           => node['mysql']['database']['charset']
  )
  owner 'www-data'
  group 'www-data'
  action :create
end

case node['platform']
when 'debian', 'ubuntu'
 service 'apache2' do
  action :restart
 end
when 'redhat', 'centos', 'fedora','amazon'
 service 'httpd' do
  action :restart
 end
end

case node['platform']
when 'debian', 'ubuntu'
 service 'mysql' do
  action :restart
 end
when 'redhat', 'centos', 'fedora','amazon'
 service 'mysqld' do
  action :restart
 end
end