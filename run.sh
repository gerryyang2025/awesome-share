#!/bin/bash

set -euo pipefail

LOG_FILE="${LOG_FILE:-run.log}"
MIN_RUBY_VERSION="${MIN_RUBY_VERSION:-3.1.0}"
AUTO_FIX="${AUTO_FIX:-1}"
RBENV_RUBY_VERSION="${RBENV_RUBY_VERSION:-3.2.3}"

echo "[run] starting..."

# Stop any previous jekyll processes started by this user.
pkill -f jekyll || true

run_cmd() {
  echo "[run] $*"
  "$@"
}

maybe_sudo() {
  if [ "${EUID:-$(id -u)}" -eq 0 ]; then
    "$@"
  else
    sudo "$@"
  fi
}

ensure_rbenv_loaded() {
  export RBENV_ROOT="${RBENV_ROOT:-$HOME/.rbenv}"
  export PATH="$RBENV_ROOT/bin:$PATH"

  if command -v rbenv >/dev/null 2>&1; then
    # shellcheck disable=SC1090
    eval "$(rbenv init - bash)"
    return 0
  fi

  return 1
}

auto_fix_ruby() {
  if [ "$AUTO_FIX" != "1" ]; then
    return 1
  fi

  if ! command -v apt-get >/dev/null 2>&1; then
    echo "[run] auto-fix skipped: apt-get not found"
    return 1
  fi

  if ! command -v git >/dev/null 2>&1; then
    echo "[run] auto-fix skipped: git not found"
    return 1
  fi

  echo "[run] attempting auto-fix: install Ruby via rbenv (target ${RBENV_RUBY_VERSION})"

  maybe_sudo apt-get update
  maybe_sudo apt-get install -y \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    libffi-dev

  export RBENV_ROOT="${RBENV_ROOT:-$HOME/.rbenv}"
  if [ ! -d "$RBENV_ROOT" ]; then
    run_cmd git clone https://github.com/rbenv/rbenv.git "$RBENV_ROOT"
  fi
  if [ ! -d "$RBENV_ROOT/plugins/ruby-build" ]; then
    run_cmd git clone https://github.com/rbenv/ruby-build.git "$RBENV_ROOT/plugins/ruby-build"
  fi

  if ! ensure_rbenv_loaded; then
    echo "[run] auto-fix failed: rbenv not available after install"
    return 1
  fi

  if ! rbenv versions --bare | grep -qx "${RBENV_RUBY_VERSION}"; then
    run_cmd rbenv install "${RBENV_RUBY_VERSION}"
  fi

  # Prefer project-local Ruby version so future runs are consistent.
  run_cmd rbenv local "${RBENV_RUBY_VERSION}"
  run_cmd rbenv rehash

  echo "[run] ruby after auto-fix: $(ruby -e 'print RUBY_VERSION')"
  return 0
}

if ! command -v ruby >/dev/null 2>&1; then
  echo "[run] ERROR: ruby not found in PATH"
  exit 1
fi

RUBY_VERSION="$(ruby -e 'print RUBY_VERSION')"
if ! printf '%s\n%s\n' "$MIN_RUBY_VERSION" "$RUBY_VERSION" | sort -V -C; then
  if auto_fix_ruby; then
    RUBY_VERSION="$(ruby -e 'print RUBY_VERSION')"
  else
    cat <<'EOF'
[run] ERROR: Ruby version too old for Chirpy/Jekyll 4.3

Chirpy requires Ruby >= 3.1 and Jekyll ~> 4.3.

Auto-fix was skipped/failed. To try auto-fix, ensure this script can:
  - run apt-get (root or sudo)
  - access github.com (git clone)

Manual fix (Ubuntu, using rbenv):
  sudo apt update
  sudo apt install -y git build-essential libssl-dev libreadline-dev zlib1g-dev libyaml-dev libffi-dev
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - bash)"
  rbenv install 3.2.3
  rbenv local 3.2.3
  gem install bundler
  bundle install

Then re-run:
  ./run.sh
EOF
    echo "[run] current ruby: ${RUBY_VERSION}"
    exit 1
  fi
fi

if ! command -v bundle >/dev/null 2>&1; then
  echo "[run] bundler not found; installing..."
  gem install bundler --no-document
fi

echo "[run] ruby: ${RUBY_VERSION}"
echo "[run] bundler: $(bundle -v)"

# Install dependencies if missing.
if ! bundle check >/dev/null 2>&1; then
  echo "[run] installing gems (bundle install)..."
  bundle install
fi

echo "[run] launching jekyll (logs: ${LOG_FILE})"
bundle exec jekyll serve >> "${LOG_FILE}" 2>&1 &
echo "[run] done. pid=$!"
