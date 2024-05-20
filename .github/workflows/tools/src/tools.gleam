import argv
import gleam/io

pub fn main() {
  case argv.load().arguments {
    ["diff", ..] -> io.println("diff")
    [cmd, ..] -> io.println("unknown command: " <> cmd)
    [] -> Nil
  }
}
