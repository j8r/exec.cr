# Exec

Basic Shell-like, async by default, command execution with no shell interpreter invocation.

## Installation

Add the dependency to your `shard.yml`:

```yaml
dependencies:
  exec:
    github: j8r/exec.cr
```

## Usage examples

Adding `.wait` ([API reference](https://crystal-lang.org/api/master/Process.html#wait%3AProcess%3A%3AStatus-instance-method)) allow to have sync execution.

Shell-like syntax. The command and its arguments are merged in a single `String`.

```crystal
output, error = Exec.run "echo hello", { |process| puts process.wait.success? } #=> true
puts output.to_s #=> hello
```

Most efficient syntax: command as `String` and arguments as `Array(String)`

```crystal
Exec.new "/bin/true", &.wait
Exec.new("/bin/ls", ["/tmp", "-l"]) {}
```

Arguments can also be a separated `String`. This is bit more efficient than being merged in a single string with the command.

```crystal
Exec.run("/bin/ls", "/tmp -l")
```

## License

Copyright (c) 2017-2019 Julien Reichardt - ISC License
