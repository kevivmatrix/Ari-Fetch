require 'spec_helper'

describe AriFetch::Engine do

  let!(:engine) { AriFetch::Engine.new("184.168.187.1", "arixml", "ARIuser1!") }

  context "initialize ari fetch" do
    subject { engine }

    context "fetch files from ftp" do
      let!(:ftp_files) { engine.ftp_files }
      subject { ftp_files }
      its(:count) { should be > 0 }
    end

    context "read and unread files" do
      its(:read_files){ should == [] }
      let!(:ftp_files) { engine.ftp_files }
      its(:unread_files) { should == ftp_files }
    end

  end
  
end