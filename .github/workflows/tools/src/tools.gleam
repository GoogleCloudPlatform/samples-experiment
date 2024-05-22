import argv
import diff
import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  let args = argv.load().arguments
  case args {
    ["diff", ..args] ->
      case args {
        [base_sha, head_sha] ->
          case diff.dirs(base_sha, head_sha) {
            Ok(dirs) -> {
              let dirs =
                list.filter(dirs, fn(x) { string.starts_with(x, "products/") })
              // ::set-output name=diffs::{"include":[{"project":"foo","config":"Debug"},{"project":"bar","config":"Release"}]}
              // io.debug(dirs)
              // io.println("Hello!")
              io.println("[\"sample1\", \"sample2\"]")
              Nil
            }
            Error(e) -> io.println_error("ERROR: " <> e)
          }
        _ -> io.println("usage: diff <base_sha> <head_sha>")
      }

    [cmd, ..] -> io.println("unknown command: " <> cmd)

    [] -> Nil
  }
}
