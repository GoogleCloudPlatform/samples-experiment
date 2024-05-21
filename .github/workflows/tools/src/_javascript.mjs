export function subprocess_status(p) {
  return p.status
}

export function subprocess_stdout(p) {
  return p.stdout.toString()
}

export function subprocess_stderr(p) {
  return p.stderr.toString()
}
