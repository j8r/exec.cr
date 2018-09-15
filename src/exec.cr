struct Exec
  @process : Process::Status
  forward_missing_to @process
  @output = IO::Memory.new
  @error = IO::Memory.new

  def initialize(cmd : String, env : Process::Env = nil, dir : String? = nil, path = ENV["PATH"]?) : Process::Status
    args = cmd.split(' ', limit: 2)
    initialize args[0], args[1]?.to_s, env, dir, path
  end

  def initialize(cmd : String, args : String, env : Process::Env = nil, dir : String? = nil, path = ENV["PATH"]?) : Process::Status
    initialize(if cmd.starts_with? '/'
      cmd
    else
      Process.find_executable(cmd, path, dir) || raise "command not found in PATH `#{path}`: " + cmd
    end, args.split(' '), env, dir)
  end

  def initialize(cmd : String, args : Array(String)? = nil, env : Process::Env = nil, dir : String? = nil) : Process::Status
    @process = Process.run command: cmd,
      args: args,
      env: env,
      clear_env: true,
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
