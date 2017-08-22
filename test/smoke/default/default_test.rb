# # encoding: utf-8

# Inspec test for recipe task1_jboss::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

describe package('java-1.8.0-openjdk') do
  it { should be_installed }
end

describe file('/opt/wildfly') do
 its('type') { should eq :directory }
 it { should be_directory }
end

describe service('wildfly') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end

describe http('http://192.168.56.11:8080/') do
  its('status') { should eq 200 }
  its('body') { should include 'WildFly' }
end

describe http('http://192.168.56.11:8080/helloworld/hi.jsp') do
  its('status') { should eq 200 }
  its('body') { should include 'Hello, World' }
end