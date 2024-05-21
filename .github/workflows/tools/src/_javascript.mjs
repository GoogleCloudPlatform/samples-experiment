import { spawnSync } from "child_process"

export function subprocess_spawn(cmd, args) {
  return spawnSync(cmd, list_to_array(args))
}

export function subprocess_status(p) {
  return p.status
}

export function subprocess_stdout(p) {
  return p.stdout.toString()
}

export function subprocess_stderr(p) {
  return p.stderr.toString()
}

function list_to_array(list) {
  if (list.head) {
    return [list.head].concat(list_to_array(list.tail))
  }
  return []
}
