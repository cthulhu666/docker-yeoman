require "spec_helper"

describe "Dockerfile" do
  before(:all) do
    base_image = Docker::Image.build_from_dir('.')
    image = Docker::Image.build_from_dir('./gulp')
    set :docker_image, image.id
  end

  describe package("sudo") do
    it { should be_installed }
  end

  describe user('yeoman') do
    it { should exist }
    it { should have_home_directory '/home/yeoman' }
  end
end

