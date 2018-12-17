require "spec"
require "../src/exec"

describe Exec do
  describe "testing return when" do
    it "true" do
      Exec.run "/bin/true", &.wait.success?.should(be_true)
    end

    it "false" do
      Exec.new "/bin/false", nil, &.wait.exit_code.should eq 1
    end

    it "echo" do
      output, error = Exec.run "echo out" { }
      sleep 0.01
      output.to_s.should eq "out\n"
    end

    it "using a shell-like syntax" do
      Exec.run "ls /tmp -l", &.wait.exit_status.should eq 0
    end

    it "using a shell-like syntax with args and cmd splitted" do
      Exec.run "ls", "/tmp -l", &.wait.exit_code.should eq 0
    end

    describe "absolute command" do
      it "with arguments in a single String" do
        Exec.run "/bin/ls /tmp -l", &.wait.exit_status.should eq 0
      end
      it "with arguments using two String" do
        Exec.run "/bin/ls", "/tmp -l", &.wait.exit_status.should eq 0
      end
      it "with arguments an using Array" do
        Exec.new "/bin/ls", {"/tmp", "-l"}, &.wait.exit_status.should eq 0
      end
      it "with a block" do
        output, error = Exec.new "/bin/pwd", chdir: "/tmp", &.wait
        output.to_s.should eq "/tmp\n"
      end
    end
  end
end
