####Test OS
describe os.name do
  it { should eq 'ubuntu' }
end

describe os.release do
  it { should eq '18.04' }
end
####Test installed packets
describe package('nginx') do
  it { should be_installed }
end

describe package('php-fpm') do
  it { should be_installed }
end

describe service('php7.2-fpm') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

####Check nginx service
describe service('nginx') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
####Check if site can return Hello World
control 'check_website' do
  describe command('curl -sL http://localhost') do
    its('stdout') {should match (/Hello World/) }
  end
end
####Check if we have removed 
describe file('default') do
  its('link_path') { should_not eq '/etc/nginx/sites-enabled/default' }
end