require 'spec_helper'

describe AriFetch::Engine do

  before(:all) {
    @engine = AriFetch::Engine.new("184.168.187.1", "arixml", "ARIuser1!")
  }

  context "initialize ari fetch" do
    subject { @engine }

    context "ftp instance" do
      subject { @engine.ftp_instance }
      its(:class) { should == Net::FTP }
    end

    context "fetch files from ftp" do
      subject { @engine.ftp_files }
      its(:class) { should == Array }
    end

    context "fetch real files from db" do
      its(:read_files){ should == [] }
    end

    context "getting list of unread files" do
      context "read file is empty" do
        before {
          @engine.stub(:read_files).and_return([])
          @engine.stub(:ftp_files).and_return(["File1"])
        }
        its(:unread_files) { should == @engine.ftp_files }
      end

      context "read file and ftp files both are not empty" do
        before {
          @engine.stub(:read_files).and_return(["File1"])
          @engine.stub(:ftp_files).and_return(["File1", "File2"])
        }
        its(:unread_files) { should == ["File2"] }
      end

      context "ftp files is empty" do
        before {
          @engine.stub(:read_files).and_return(["File1", "File2"])
          @engine.stub(:ftp_files).and_return([])
        }
        its(:unread_files) { should == [] }
      end
    end

  end
end