# <img src="assets/logo.svg" width="36" height="36" alt="" /> Porthole

**See what your agents are doing.**

[![CI](https://github.com/smeltery/porthole/actions/workflows/ci.yml/badge.svg)](https://github.com/smeltery/porthole/actions/workflows/ci.yml)
[![Release](https://img.shields.io/github/v/release/smeltery/porthole)](https://github.com/smeltery/porthole/releases)
[![Swift](https://img.shields.io/badge/Swift-native-4c766b?logo=swift)](docs/development.md)
[![Bun](https://img.shields.io/badge/Bun-tooling-282a36?logo=bun)](package.json)
[![Flox](https://img.shields.io/badge/Flox-reproducible-845ef7)](.flox/env/manifest.toml)
[![License](https://img.shields.io/badge/license-PolyForm_Shield-blue)](LICENSE)

Porthole is a native Mac app that shows the test VM live, groups commands by agent and chat, and flags overlapping sessions. Slipway drives the VM; Porthole watches.

```sh
git clone https://github.com/smeltery/porthole.git
cd porthole
flox activate -- bun install --frozen-lockfile
flox activate -- bun run check
```

[Install and start](docs/getting-started.md) · [Documentation](docs/README.md) ·
[Website](https://smeltery.github.io/porthole/) · [Releases](https://github.com/smeltery/porthole/releases)

Requires macOS for app testing. Local Tart VMs require Apple silicon; an existing
remote Mac can also be used. See [requirements](docs/getting-started.md).

Licensed under the exact [Smeltery Hab license](LICENSE). Upstream MIT notices
are preserved in [provenance](docs/provenance.md).
