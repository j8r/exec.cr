module Exec
  # Yields a `Process::Status` and returns a Tuple with the stdout and stderr.
  def self.run(cmd : String, **process_args, &block : Process -> _) : Tuple
    args = cmd.partition ' '
    run(**process_args.merge(cmd: args[0], args: args[2])) { |process| yield process }
  end

  # :ditto:
  def self.run(cmd : String, args : String, chdir : String? = nil, env : Process::Env? = nil, **process_args, &block : Process -> _) : Tuple
    command = if cmd.starts_with? '/'
                cmd
              else
                path = env ? env["PATH"]? : ENV["PATH"]?
                Process.find_executable(cmd, path, chdir) || raise "command not found in PATH `#{path}`: " + cmd
              end

    new(**process_args.merge(command: command, args: args.split(' '), chdir: chdir)) { |process| yield process }
  end

  # :ditto:
  def self.new(
    command : String,
    args : Array | Tuple | Nil = nil,
    chdir : String? = nil,
    output = IO::Memory.new,
    error = IO::Memory.new,
    **process_args,
    &block : Process -> _
  ) : Tuple
    process = Process.new **process_args.merge(command: command, args: args, chdir: chdir, output: output, error: error)
    yield process
    {output, error}
  end
end
