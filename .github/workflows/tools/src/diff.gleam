import gleam/io
import gleam/string
import subprocess

pub fn files(base_sha: String, head_sha: String) -> Result(List(String), String) {
  case subprocess.run("git", ["diff", "--name-only", base_sha, head_sha]) {
    Ok(p) -> Ok(string.split(string.trim(p.stdout), on: "\n"))
    Error(p) -> Error(p.stderr)
  }
}

pub fn dirs(base_sha: String, head_sha: String) -> Result(List(String), String) {
  files(base_sha, head_sha)
}
