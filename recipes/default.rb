
ruby_block 'Set HIVE_HOME in /etc/profile' do
  block do
    file = Chef::Util::FileEdit.new('/etc/profile')
    file.search_file_delete_line('HIVE_HOME')
    file.insert_line_if_no_match('export HIVE_HOME=', "export HIVE_HOME=#{node['mapr']['hive_dir']}")
    file.insert_line_if_no_match("export PATH=\$PATH:\$HIVE_HOME/bin", 'export PATH=$PATH:$HIVE_HOME/bin')
    file.write_file
  end
end

directory node['mapr']['hive_dir'] do
  user 'root'
  group 'root'
  mode '755'
  recursive true
  action :create
end

data = data_bag_item( 'mapr_hive', 'hive' )

template "#{node['mapr']['hive_dir']}hive-site.xml" do
  variables( 
    :mysql_password => data['mysql_password'],
    :mysql_user => data['mysql_user'] )
  source 'hive_site.conf.erb'
  mode 0644
  action :create
end

bash 'run configure.sh -R' do
  command  '/opt/mapr/server/configure.sh -R'
end
