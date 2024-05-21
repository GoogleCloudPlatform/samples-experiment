import argv
import diff
import gleam/io

pub fn main() {
  let args = argv.load().arguments
  case args {
    ["diff", ..args] ->
      case args {
        [base_sha, head_sha, ..] ->
          case diff.dirs(base_sha, head_sha) {
            Ok(dirs) -> {
              io.debug(dirs)
              Nil
            }
            Error(e) -> io.println_error("ERROR: " <> e)
          }
        _ -> io.println("usage: diff <base_sha> <head_sha>")
      }
    [cmd, ..] -> io.println("unknown command: " <> cmd)
    xs -> {
      io.debug(xs)
      io.println("Nothing to do")
    }
  }
}
