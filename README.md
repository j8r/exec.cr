# Exec

Thin Process wrapper for simple execution of programs with arguments

## Installation

Add the dependency to your `shard.yml`:

```yaml
dependencies:
  exec:
    github: j8r/exec.cr
```

## Usage

### Methods

`#out(strict = false) : String`: Return the output (stdout) of the process as a `String` if exited normally with an exit code of 0, else return the error (stderr) or raise the error when `strict = true`

`#output : String`: Return the stdout

`#error : String`: Return the stderr

Other methods are available, forwarded from [Process::Status](https://crystal-lang.org/api/latest/Process/Status.html)

### Examples

```crystal
Exec.new("/bin/true").success? # true
```
Most efficient syntax

```crystal
Exec.new("/bin/true", nil).success? # true
Exec.new("/bin/ls", ["/tmp", "-l"]).exit_status # 0
```

Shell-like syntax. No shell interpreter sub-process is invocated.
```crystal
Exec.new("ls /tmp -l").exit_status # 0
```

Other syntaxes are also supported
```crystal
Exec.new("/bin/ls /tmp -l")
Exec.new("/bin/ls", "/tmp -l")
Exec.new("ls", "/tmp -l")

Exec.new("/bin/pwd", args: nil, dir: "/tmp").out # "/tmp\n"
```

## License

Copyright (c) 2017 - 2018 Julien Reichardt - ISC License
