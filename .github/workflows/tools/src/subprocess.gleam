import gleam/io

pub type Process {
  Process(status: Int, stdout: String, stderr: String)
}

pub fn run(cmd: String, args: List(String)) -> Result(Process, Process) {
  // let p = spawn("ls", ["-lh"])
  let p = spawn(cmd, args)
  let ret = Process(status: status(p), stdout: stdout(p), stderr: stderr(p))
  case ret.status {
    0 -> Ok(ret)
    _ -> Error(ret)
  }
}

//==-- Private --==\\

type ProcessJs

// https://nodejs.org/api/child_process.html#child_processspawnsynccommand-args-options
@external(javascript, "./_javascript.mjs", "subprocess_spawn")
fn spawn(cmd: String, args: List(String)) -> ProcessJs

@external(javascript, "./_javascript.mjs", "subprocess_status")
fn status(p: ProcessJs) -> Int

@external(javascript, "./_javascript.mjs", "subprocess_stdout")
fn stdout(p: ProcessJs) -> String

@external(javascript, "./_javascript.mjs", "subprocess_stderr")
fn stderr(p: ProcessJs) -> String
