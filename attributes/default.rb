default.mysql[:datadir] = "/var/lib/mysql"
default.mysql[:logdir]  = "/var/log/mysql"
default.mysql[:server_root_password] = "password"
default.mysql[:server_root_user] = "root"
default.mysql[:server_root_new_user] = "test"
default.mysql[:server_root_new_user_pwd] = "test"
default.mysql[:server_db_name] = "wb"

default['wordpress']['website']['title'] = 'REANCLOUD'
default['wordpress']['admin']['username'] = 'admin'
default['wordpress']['admin']['password'] = 'admin123$'
default['wordpress']['admin']['email'] = 'pavankumar.amballa@reancloud.com'

default['mysql']['database']['host'] = 'localhost'
default['mysql']['database']['dbname'] = 'wp'
default['mysql']['database']['root_user'] = 'root'
default['mysql']['database']['root_pwd'] = 'password'
default['mysql']['database']['new_user'] = 'test'
default['mysql']['database']['new_user_pwd'] = 'test'
default['mysql']['database']['charset'] = 'utf8'
default['mysql']['database']['collate'] = ''
default['mysql']['database']['datadir']= '/var/lib/mysql'
default['mysql']['database']['logdir']= '/var/log/mysql'