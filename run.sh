#!/bin/bash

set -euo pipefail

LOG_FILE="${LOG_FILE:-run.log}"
MIN_RUBY_VERSION="${MIN_RUBY_VERSION:-3.1.0}"

echo "[run] starting..."

# Stop any previous jekyll processes started by this user.
pkill -f jekyll || true

if ! command -v ruby >/dev/null 2>&1; then
  echo "[run] ERROR: ruby not found in PATH"
  exit 1
fi

RUBY_VERSION="$(ruby -e 'print RUBY_VERSION')"
if ! printf '%s\n%s\n' "$MIN_RUBY_VERSION" "$RUBY_VERSION" | sort -V -C; then
  cat <<'EOF'
[run] ERROR: Ruby version too old for Chirpy/Jekyll 4.3

Chirpy requires Ruby >= 3.1 and Jekyll ~> 4.3.

Suggested fix (Ubuntu, using rbenv):
  sudo apt update
  sudo apt install -y git build-essential libssl-dev libreadline-dev zlib1g-dev libyaml-dev libffi-dev
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(rbenv init -)"' >> ~/.bashrc
  source ~/.bashrc
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
