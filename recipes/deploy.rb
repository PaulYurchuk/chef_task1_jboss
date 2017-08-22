remote_file '/tmp/HelloWorldWebApp.zip' do
  source 'http://centerkey.com/jboss/HelloWorldWebApp.zip'
  mode '0775'
  action :create
end

execute 'extract HelloWorldWebApp' do
  command 'unzip HelloWorldWebApp.zip'
  cwd '/tmp'
  not_if { Dir.exists?("/tmp/HellowWorld") }
end

remote_file '/opt/wildfly/standalone/deployments/helloworld.war' do
  source 'file:///tmp/HellowWorld/helloworld.war'
  mode '0755'
  action :create
  notifies :restart, 'service[wildfly]', :immediately
end

bash 'deploy after sleeping' do
  code <<-EOH
  sleep 30
  EOH
end