# Exec

Thin Process wrapper for simple execution of programs with arguments

## Installation

Add this block to your application's `shard.yml`:

```yaml
dependencies:
  exec:
    github: j8r/exec
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

Exec.new("/bin/ls", ["/tmp", "-lh"]).exit_status # 0

Exec.new("/bin/pwd", args: "", dir: "/tmp").out # "/tmp\n"
```

## License

Copyright (c) 2017 - 2018 Julien Reichardt - ISC License
