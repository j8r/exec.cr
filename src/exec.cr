struct Exec
  getter run : Process::Status
  forward_missing_to @run

  def initialize(cmd : String, arg : String, dir : String? = nil) : Process::Status
    initialize cmd, arg.split(' '), dir
  end

  def initialize(cmd : String, args : Array(String)? = nil, dir : String? = nil) : Process::Status
    @output = IO::Memory.new
    @error = IO::Memory.new
    @run = Process.run command: cmd,
      args: args,
      env: nil,
      clear_env: false,
      shell: false,
      output: @output,
      error: @error,
      chdir: dir
  end

  def out(strict = true) : String
    if success?
      @output
    else
      strict ? raise @error.to_s : @error
    end.to_s
  end

  def output : String
    @output.to_s
  end

  def error : String
    @error.to_s
  end
end
