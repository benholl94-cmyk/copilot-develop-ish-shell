# Copilot Develop ish-shell

Production-ready shell setup for portable development environments.

## Quick start

```bash
chmod +x bin/ish-shell scripts/*.sh
./scripts/bootstrap.sh
./scripts/build.sh
./bin/ish-shell --health-check
./bin/ish-shell --version
./scripts/grade-workbase.sh
./scripts/grade-codebase.sh
```

## Features

- Portable path resolution
- Shell-based build automation
- Workbase and codebase graders
- Structured logs and environment management
- System-level link installation support

## Production notes

This repo is suitable as a workbase/codebase pattern for shell-based tooling that must run from arbitrary directories while maintaining predictable application structure.
