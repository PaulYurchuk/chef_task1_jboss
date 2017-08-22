include_recipe 'java'

package 'unzip'

remote_file '/tmp/wildfly-10.1.0.Final.tar.gz' do
  source 'http://download.jboss.org/wildfly/10.1.0.Final/wildfly-10.1.0.Final.tar.gz'
  mode '0775'
  action :create
end

user 'wildfly' do
  comment 'Wildfly System User'
  shell '/sbin/nologin'
  system true
  action [:create, :lock]
end

group 'wildfly' do
  action :create
  members 'wildfly'
  append true
end

execute 'Prepare WildFly' do
  command 'tar -xzf wildfly-10.1.0.Final.tar.gz'
  cwd '/tmp'
  not_if { Dir.exists?("/tmp/wildfly-10.1.0.Final") }
end

bash 'Install WildFly' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  mv wildfly-10.1.0.Final /opt/wildfly
  chown -R wildfly:wildfly /opt/wildfly
  chmod -R 775 /opt/wildfly
  sed -i 's;127.0.0.1;192.168.56.11;g' /opt/wildfly/standalone/configuration/standalone.xml
  EOH
end

template '/usr/lib/systemd/system/wildfly.service' do
  source 'wildfly.service'
end

service 'wildfly' do
  action [:enable, :start]
  supports [:stop, :reload, :restart] => true
end