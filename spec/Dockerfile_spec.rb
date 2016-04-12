# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
 
  image = Docker::Image.build_from_dir('.')
  let (:node_ver) {  image.run('nodejs --version').logs(stdout: true) }
  set :os, family: :debian
  set :backend, :docker
  set :docker_image, image.id

  it "should install the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu 14")
  end

  ['nodejs', 'curl', 'build-essential'].each do |package|
    it "should install package #{package}" do 
      expect(package("#{package}")).to be_installed
    end
  end
  
  describe 'Application folders and files configured' do
    describe file('/app') do
      it { should be_directory }
    end
    describe command('pwd') do
      its(:stdout) { should match(/app/) }
    end
    describe file('/app/package.json') do
      it { should exist }
      it { should be_file }
    end
    describe file('/app/node_modules') do
      it { should exist }
      it { should be_directory }
    end      
  end 		   

  describe user ('jawn') do
    it { should exist }
  end

  it 'should run with correct version of nodejs' do
    expect(node_ver).to include("v4") 
  end

  def os_version
    command("cat /etc/issue").stdout
  end	  

end
