case node['platform']
when 'debian', 'ubuntu'
 execute 'apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd -y'
when 'redhat', 'centos', 'fedora','amazon'
 execute 'yum install php php-mysql php-devel php-gd php-pecl-memcache php-pspell php-snmp php-xmlrpc php-xml -y'
end

remote_file "/tmp/latest.tar.gz" do
   source "http://wordpress.org/latest.tar.gz"
end

execute 'extract_wp' do
  command 'tar -xzvf /tmp/latest.tar.gz -C /tmp/'
end


execute 'move_files' do
  command 'rsync -av /tmp/wordpress/* /var/www/html/'
end

execute 'permissions1' do
  command 'chown -R www-data:www-data /var/www/html/'
end

execute 'permissions2' do
  command 'chmod -R 755 /var/www/html/'
end

execute 'move_file2' do
  command 'mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php'
end

mysql_database node['mysql']['database']['dbname'] do
  connection(
    :host => node['mysql']['database']['host'],
    :username => node['mysql']['database']['root_user'],
    :password => node['mysql']['database']['root_pwd']
  )
  action :create
end

mysql_database_user node['mysql']['database']['new_user'] do
  connection(
    :host => node['mysql']['database']['host'],
    :username => node['mysql']['database']['root_user'],
    :password => node['mysql']['database']['root_pwd']
  )
  password node['mysql']['database']['new_user_pwd']
  database_name node['mysql']['database']['dbname']
  host node['mysql']['database']['host']
  action [:create, :grant]
  sql "flush privileges"
end

include_recipe 'wp::admin_setup'

