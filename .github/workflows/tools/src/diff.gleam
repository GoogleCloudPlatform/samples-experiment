import gleam/list
import gleam/string
import subprocess

pub fn files(base_sha: String, head_sha: String) -> Result(List(String), String) {
  case subprocess.run("git", ["diff", "--name-only", base_sha, head_sha]) {
    Ok(p) -> Ok(string.split(string.trim(p.stdout), on: "\n"))
    Error(p) -> Error(p.stderr)
  }
}

pub fn dirs(base_sha: String, head_sha: String) -> Result(List(String), String) {
  case files(base_sha, head_sha) {
    Ok(paths) -> Ok(list.unique(list.map(paths, dirname)))
    Error(e) -> Error(e)
  }
}

fn dirname(path: String) -> String {
  let parts = string.split(path, "/")
  list.take(parts, list.length(parts) - 1)
  |> string.join("/")
}
