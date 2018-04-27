#!/usr/bin/env bash

set -e


main() {
  local localenv_name="${1:-localenv}"
  local localenv_path="${HOME}/${localenv_name}"

  mkdir -p "${localenv_path}"

  git -C "${localenv_path}" init
  git -C "${localenv_path}" remote add origin \
      "https://cathook@github.com/cathook/LocalEnv"
  git -C "${localenv_path}" fetch origin framework
  git -C "${localenv_path}" checkout origin/framework

  echo '
{
  "repos": [
    [
      "cathook-LocalEnv",
      "https://cathook@github.com/cathook/LocalEnv",
      "installers"
    ]
  ]
}
' > "${localenv_path}/manifest.json"
  "${localenv_path}/bin/localenv" update

  "${localenv_path}/bin/localenv" install --install-deps env_basic
}

main "${@}"
