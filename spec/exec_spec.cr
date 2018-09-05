require "./spec_helper"

describe Exec do
  describe "testing the return" do
    it "runs true" do
      Exec.new("/bin/true").success?.should be_true
    end
    it "runs false" do
      Exec.new("/bin/false").exit_code.should eq 1
    end
    it "arguments inside the command" do
      Exec.new("/bin/ls /tmp -l").exit_status.should eq 0
    end
    it "arguments using String" do
      Exec.new("/bin/ls", "/tmp -l").exit_status.should eq 0
    end
    it "arguments using Array" do
      Exec.new("/bin/ls", ["/tmp", "-l"]).exit_status.should eq 0
    end
    it "arguments using Array of Strings, check the output String" do
      Exec.new("/bin/pwd", args: "", dir: "/tmp").out.should eq "/tmp\n"
    end
  end
end
