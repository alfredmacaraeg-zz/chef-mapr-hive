
yum_package 'mapr-hiveserver2' do
  version node['mapr']['hive_yum_version']
end
