struct Exec
  @process : Process::Status
  forward_missing_to @process

  def initialize(cmd : String, args : String, env : Process::Env = nil, dir : String? = nil) : Process::Status
    initialize cmd, args.split(' '), env, dir
  end

  def initialize(cmd : String, args : Array(String)? = nil, env : Process::Env = nil, dir : String? = nil) : Process::Status
    @output = IO::Memory.new
    @error = IO::Memory.new
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
