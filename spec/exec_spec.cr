require "./spec_helper"

describe Exec do
  describe "testing return when" do
    it "true" do
      Exec.new("/bin/true").success?.should be_true
    end
    it "false" do
      Exec.new("/bin/false", nil).exit_code.should eq 1
    end
    it "using a shell-like syntax" do
      Exec.new("ls /tmp -l").exit_status.should eq 0
    end
    it "using a shell-like syntax with args and cmd splitted" do
      Exec.new("ls", "/tmp -l").exit_status.should eq 0
    end

    describe "absolute command" do
      it "with arguments in a single String" do
        Exec.new("/bin/ls /tmp -l").exit_status.should eq 0
      end
      it "with arguments using two String" do
        Exec.new("/bin/ls", "/tmp -l").exit_status.should eq 0
      end
      it "with arguments an using Array" do
        Exec.new("/bin/ls", ["/tmp", "-l"]).exit_status.should eq 0
      end
      it "with a directory" do
        Exec.new("/bin/pwd", args: nil, dir: "/tmp").out.should eq "/tmp\n"
      end
    end
  end
end
