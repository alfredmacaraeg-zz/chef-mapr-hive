# encoding: utf-8

require 'chefspec'
require 'chefspec/berkshelf'
require 'spec_helper'

describe 'mapr_hive::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
    end.converge(described_recipe)
  end

  it 'should edit /etc/profile and add the included lines' do
    expect(chef_run).to run_ruby_block('Set HIVE_HOME in /etc/profile')
  end

  it 'should create hive conf directory /opt/mapr/hive/0.13/conf/' do
    expect(chef_run).to create_directory('/opt/mapr/hive/0.13/conf/')
  end
  
  it 'should create hive-site configuration file based on template' do
    expect(chef_run).to create_template('/opt/mapr/hive/0.13/conf/hive-site.xml')
  end
  
  it 'should run configure.sh -R' do
    expect(chef_run).to run_bash('/opt/mapr/server/configure.sh -R')
  end

end

describe 'mapr_hive::mapr_hive' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
    end.converge(described_recipe)
  end

  it 'should install mapr-hive' do
    expect(chef_run).to install_package('mapr-hive')
  end

end

describe 'mapr_hive::mapr_hs2' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
    end.converge(described_recipe)
  end

  it 'should install mapr-hiveserver2' do
    expect(chef_run).to install_package('mapr-hiveserver2')
  end

end

describe 'mapr_hive::mapr_metastore' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
    end.converge(described_recipe)
  end

  it 'should install mapr-hivemetastore' do
    expect(chef_run).to install_package('mapr-hivemetastore')
  end

end
