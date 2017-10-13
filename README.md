# exec

Simple library to execute a program with arguments from Crystal

## Installation

Add this block to your application's `shard.yml`:

```yaml
dependencies:
  exec:
    github: j8r/exec
```

## Usage

### Methods

`out` : String - return the stdout("output") of the process if it exited normally with an exit code of 0, else return the stderr("error")

`exit_code`, `exit_signal`, `exit_status`, `normal_exit?`, `signal_exit?`, `success?`: same as the ones in the [official Crystal API docs](https://crystal-lang.org/api/latest/Process/Status.html)

### Examples

```crystal
Exec.new("/bin/true").success? # true

Exec.new("/bin/ls", ["/tmp", "-lh"]).exit_status # 0

Exec.new("/bin/pwd", "", "/tmp").out # "/tmp\n"
```

## License

Copyright (c) 2017 Julien Reichardt - ISC License
