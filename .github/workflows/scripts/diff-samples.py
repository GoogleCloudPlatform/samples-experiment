# Copyright 2024 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import os
import subprocess
from fnmatch import fnmatch


def diff_samples(base: str, branch: str, pattern: str = "") -> list[str]:
    p = subprocess.run(
        ["git", "diff", "--name-only", base, branch],
        check=True,
        stdout=subprocess.PIPE,
    )
    files = p.stdout.decode().splitlines()
    dirs = list({os.path.dirname(f) for f in files if fnmatch(f, f"{pattern}*")})
    return dirs


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser()
    parser.add_argument("base", help="base branch")
    parser.add_argument("branch", help="pull request branch")
    parser.add_argument("--pattern", default="", help="glob pattern filter")
    args = parser.parse_args()

    print(diff_samples(args.base, args.branch, args.pattern))
