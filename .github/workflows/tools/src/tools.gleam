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
        [language, base_sha, head_sha] ->
          case diff.files(base_sha, head_sha) {
            Ok(dirs) -> {
              let diffs =
                dirs
                |> list.filter(fn(x) { string.starts_with(x, "products/") })
                |> list.filter(fn(x) {
                  string.contains(x, "/" <> language <> "/")
                })
              io.println(string.inspect(diffs))
            }
            Error(e) -> io.println_error("ERROR: " <> e)
          }
        _ -> io.println("usage: diff <language> <base_sha> <head_sha>")
      }

    [cmd, ..] -> io.println("unknown command: " <> cmd)

    [] -> Nil
  }
}
