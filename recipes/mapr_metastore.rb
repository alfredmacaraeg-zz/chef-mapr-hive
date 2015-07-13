
yum_package 'mapr-hivemetastore' do
  version node['mapr']['hive_yum_version']
end
