---
name: jekyll-linux-serve
description: >-
  Keep this Jekyll blog's Mac and 1 GB Ubuntu serve path from crashing.
  Use when editing optools, _config.yml, Gemfile, Gemfile.lock, README install
  steps, or when logs show Cannot allocate memory, run.log regeneration,
  dart-sass, sass-embedded, EADDRNOTAVAIL, or a Jekyll PID that exits immediately.
---

# Jekyll serve on the 1 GB Linux host

The production host is an Ubuntu x86_64 VM with **1 GB RAM**. `./optools start` backgrounds `bundle exec jekyll serve` with `nohup`, appends stdout to `run.log`, and writes `.jekyll.pid`. Ruby is **3.2.3**. Bundler is **2.4.19**.

## run.log rebuild loop

On 2026-11-17 the first generation finished (`done in ~50s`, `Server running... http://0.0.0.0:8080/`). Jekyll then logged:

```text
Regenerating: 1 file(s) changed at ...
              run.log
Conversion error: ... sass-embedded-1.98.0-x86_64-linux-gnu/.../dart-sass/src/dart
Cannot allocate memory
```

That repeated until the process died. `run.log` lives in the source tree, so each log line is a watched change. The rebuild starts `dart` again while Ruby still holds the RAM. The kernel cannot allocate memory for that second process. The error is appended to `run.log`, which starts another rebuild.

A healthy start stops at `Server running... press ctrl-c to stop.` The shell prompt returning is expected: `optools` does not stay in the foreground. There must be no later `Regenerating` line whose only changed file is `run.log`.

Keep both names in `_config.yml` `exclude`:

```yaml
exclude:
  - run.log
  - .jekyll.pid
```

Do not point `LOG_FILE` at another path inside the Jekyll source. Do not remove those exclude entries. Jekyll's watcher only ignores an exclude entry that already exists when the listener starts; `optools` creates `run.log` before `jekyll serve`, so leave that order alone.

Go and Helm examples use `{{ }}`. Liquid runs before Markdown, so a code fence does not protect them. Wrap those examples in `{% raw %} ... {% endraw %}` and leave the visible command text unchanged. The tag spelling is `tRPC-Go` on every post; `trpc-go` and `tRPC-Go` both slugify to `_site/tags/trpc-go/index.html`, and the second write overwrites the first.

## Locked gems

`Cannot allocate memory` during `bundle install` is a different failure. A lockfile written by Bundler 4 pulled `json` 2.21.2, and compiling it on this VM killed Ruby itself (`Cannot allocate memory - .../bin/ruby`).

Install only the committed lockfile: Bundler **2.4.19**, `json` **2.19.1**, `sass-embedded` **1.98.0**, `google-protobuf` **4.34.0**, `ffi` **1.17.3**, Jekyll **4.4.1**, Chirpy **7.5.0**. Command: `bundle _2.4.19_ install`. Do not run `bundle update` or regenerate the lockfile. Keep `arm64-darwin` and `x86_64-linux` on those same versions.

If an untracked `Gemfile.lock` blocks `git pull`, move it aside, pull, then install the committed file. Do not commit `.bundle/`.

## Process and bind

- `detach` stays **false**. Jekyll's own detach exits the PID stored in `.jekyll.pid` and turns regeneration off. Backgrounding is `nohup` inside `optools`.
- `host` stays **0.0.0.0**. `127.0.0.1` is unreachable from outside the Linux VM. A pinned address such as `172.19.0.16` raises `EADDRNOTAVAIL` on the Mac. Pin with `JEKYLL_HOST=... ./optools start` only for that launch.
- `./optools start` must keep a UTF-8 locale. `LANG=C` fails on Chinese filenames with `Encoding::UndefinedConversionError` (`"\xE9" from ASCII-8BIT to UTF-8`).

If a real post or SCSS edit still cannot start `dart` on the 1 GB host, add the 2 GB swap in `README.md` and `./optools restart`. Do not change gem versions to work around that.
