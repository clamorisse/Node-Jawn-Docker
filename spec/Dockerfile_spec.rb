# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end

  def os_version
    command("lsb_release -a").stdout
  end

   it "installs the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu 14")
  end

  ['nodejs', 'nodejs-legacy', 'npm'].each do |package|
	
    it "installs package #{package}" do 
      expect(package("#{package}")).to be_installed
    end
  end

#  it ' should be listening on port 80' do
#	 expect().to be_reacheable.with( :port => 80)
#  end 

  def os_version
    command("lsb_release -a").stdout
  end
end
