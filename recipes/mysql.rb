include_recipe 'apt'


case node['platform']
when 'debian', 'ubuntu'
 package 'mysql-server'
when 'redhat', 'centos', 'fedora','amazon'
  package 'mysql'
end


directory node[:mysql][:datadir]  do
  owner 'mysql'
  group 'mysql'
  mode '0755'
  action :create
end

directory node[:mysql][:logdir]  do
  owner 'mysql'
  group 'mysql' 
  mode '0755'
  action :create
end


case node['platform']
when 'debian', 'ubuntu'
 service 'mysql' do
  action :enable
 end
when 'redhat', 'centos', 'fedora','amazon'
 service 'mysqld' do
  action :enable
 end
end


case node['platform']
when 'debian', 'ubuntu'
 service 'mysql' do
  action :start
 end
when 'redhat', 'centos', 'fedora','amazon'
 service 'mysqld' do
  action :start
 end
end

execute 'assign root password' do
  command "/usr/bin/mysqladmin -u \"#{node['mysql']['database']['root_user']}\" password \"#{node['mysql']['database']['root_pwd']}\""
  action :run
  only_if "/usr/bin/mysql -u \"#{node['mysql']['database']['root_user']}\" -e 'show databases;'"
end
#{node['wordpress']['admin_dir']
case node['platform']
when 'debian', 'ubuntu'
	ruby_block "mysql datadir" do
	  block do
		fe = Chef::Util::FileEdit.new("/etc/mysql/my.cnf")
		fe.search_file_replace(/datadir.*/,"datadir         = #{node['mysql']['database']['datadir']}")
		fe.search_file_replace(/log_error.*/,"log_error = #{node['mysql']['database']['logdir']}/error.log")
		fe.write_file
	  end
	end
when 'redhat', 'centos', 'fedora','amazon'
	ruby_block "mysqld datadir" do
	  block do
		fe = Chef::Util::FileEdit.new("/etc/my.cnf")
		fe.search_file_replace(/datadir.*/,"datadir         = #{node['mysql']['database']['datadir']}")
		fe.search_file_replace(/log_error.*/,"log_error = #{node['mysql']['database']['logdir']}/error.log")
		fe.write_file
	  end
	end
end


include_recipe 'wp::wordp'
