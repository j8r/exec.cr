struct Exec
  getter run : Process::Status

  def initialize(cmd : String, all_args : String | Array(String)? = nil, dir : String? = nil) : Process::Status
    all_args = all_args.split(" ").to_a if all_args.is_a? String
    @output = IO::Memory.new
    @error = IO::Memory.new
    @run = Process.run(command: cmd,
      args: all_args,
      env: nil,
      clear_env: false,
      shell: false,
      output: @output,
      error: @error,
      chdir: dir)
  end

  def out
    @output.empty? ? @error.to_s : @output.to_s
  end

  def output
    @output.to_s
  end

  def error
    @error.to_s
  end

  # from https://crystal-lang.org/api/latest/Process/Status.html
  def exit_code
    @run.exit_code
  end

  def exit_signal
    @run.exit_signal
  end

  def exit_status
    @run.exit_status
  end

  def normal_exit?
    @run.normal_exit?
  end

  def signal_exit?
    @run.signal_exit?
  end

  def success?
    @run.success?
  end
end
