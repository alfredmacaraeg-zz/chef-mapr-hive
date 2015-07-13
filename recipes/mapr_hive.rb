
yum_package 'mapr-hive' do
  version node['mapr']['hive_yum_version']
end
