require "./spec_helper"

describe Exec do
  describe "Test the return of several program executions" do
    it "run true" do
      Exec.new("/bin/true").success?.should be_true
    end
    it "run false" do
      Exec.new("/bin/false").exit_code.should eq 1
    end
    it "arguments using String, 0 as exit status" do
      Exec.new("/bin/ls", ["/tmp", "-lh"]).exit_status.should eq 0
    end
    it "arguments using Array of Strings, check the output String" do
      Exec.new("/bin/pwd", args: "", dir: "/tmp").out.should eq "/tmp\n"
    end
  end
end
