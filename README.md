<div align="center">

# 🤖 Anthropic CLI

**Containerized `ant` CLI (Hardened)**

[![build_status_badge](../../actions/workflows/docker-image-native-multiplatform-pipeline.yaml/badge.svg?branch=main)](.github/workflows/docker-image-native-multiplatform-pipeline.yaml)
[![AnthropicCLI](https://img.shields.io/badge/GitHub-Repository-blue?logo=github)](https://github.com/anthropics/anthropic-cli)
[![Documentation](https://img.shields.io/badge/Docs-Anthropic-green?logo=github)](https://platform.claude.com/docs/en/cli-sdks-libraries/cli/quickstart)

</div>

---

## 📦 Latest Build

<!-- VERSION_INFO_START -->
| Component | Version |
|-----------|---------|
| **Anthropic CLI** | [`1.23.0`](https://github.com/anthropics/anthropic-cli/releases/tag/v1.23.0) |

> 🔄 Last updated: 2026-08-13T20:30:16Z · [Build #6](https://github.com/stefanbosak/anthropic-cli/actions/runs/31740976209)
<!-- VERSION_INFO_END -->

---

## 📋 Overview

This repository provides a fully automated preparation of a <span style="color: #0969da;">**containerized**</span> [`ant` CLI](https://github.com/anthropics/anthropic-cli) environment — the typed command-line client for the Claude **Messages API** (distinct from the agentic [Claude Code](https://github.com/anthropics/claude-code) CLI).

### About solution
- Sandboxing environment for API-calling scope (reduced possible negative impact via isolation)
- Automated packaging of the current `ant` release version (optimized maintenance effort via automation)
- Strong focus on security (mitigated security issues and vulnerabilities through hardening)
- Simplification of the initial run-up (see: [Dockerfile](./Dockerfile))

- **Container image is:**
  - keyless-signed via cosign using GitHub OIDC certificate issuer (trusted verifiable source)
  - automatically built when a new release of `anthropic-cli` is detected (scheduled monitoring - every 2 hours)

### 📚 Resources

- 📖 [CLI Quickstart](https://platform.claude.com/docs/en/cli-sdks-libraries/cli/quickstart)
- 📖 [Using the CLI](https://platform.claude.com/docs/en/cli-sdks-libraries/cli/using)
- 📖 [CLI scripting and automation](https://platform.claude.com/docs/en/cli-sdks-libraries/cli/scripting)
- 📖 [CLI authentication options](https://platform.claude.com/docs/en/cli-sdks-libraries/cli/authentication)

## Anthropic IP prefixes, subdomains for whitelisting, status
- [Anthropic IP prefixes](https://docs.anthropic.com/en/api/ip-addresses)
- curl -s https://status.claude.com/api/v2/summary.json | jq '.status'

### ⚠️ Important Notices

> [!NOTE]
> All files in this repository are well-commented with relevant implementation details.

> [!IMPORTANT]
> Always review and understand the code before executing any commands.

> [!CAUTION]
> Users are solely responsible for any modifications or execution of code from this repository.

## 📁 Repository Structure

### <span style="color: #0969da;">Docker & Build</span>
| File | Description |
|------|-------------|
| [`Dockerfile`](./Dockerfile) | <span style="color: #0969da;">Container image configuration</span> |

### <span style="color: #1a7f37;">GitHub Workflows</span>
| File | Description |
|------|-------------|
| [`monitor-release.yaml`](./.github/workflows/monitor-release.yaml) | <span style="color: #1a7f37;">Watches `anthropics/anthropic-cli` for new releases and dispatches a build</span> |
| [`docker-image-native-multiplatform-pipeline.yaml`](./.github/workflows/docker-image-native-multiplatform-pipeline.yaml) | <span style="color: #1a7f37;">Native (per-arch runner) build → test → scan → sign pipeline</span> |
| [`docker-image-emulated-multiplatform-pipeline.yaml`](./.github/workflows/docker-image-emulated-multiplatform-pipeline.yaml) | <span style="color: #1a7f37;">QEMU-emulated multi-arch build → test → scan → sign pipeline</span> |

## 🐳 Container Images

### <span style="color: #0969da;">Available Registries</span>

| Registry | Network Support | Pull Command |
|----------|----------------|--------------|
| [**GitHub CR**](https://github.com/stefanbosak/anthropic-cli/pkgs/container/anthropic-cli) | <span style="color: #8250df;">IPv4 only</span> | `docker pull ghcr.io/stefanbosak/anthropic-cli:initial` |
| [**Docker Hub**](https://hub.docker.com/r/developmententity/anthropic-cli) | <span style="color: #1a7f37;">IPv4 & IPv6</span> | `docker pull developmententity/anthropic-cli:initial` |

## Other resources

- [Anthropic CLI (upstream repo)](https://github.com/anthropics/anthropic-cli)
- [Anthropic API documentation](https://platform.claude.com/docs/en/api/overview)

---

<div align="center">

<span style="color: #8250df;">**Made with ❤ for ⚡ efficiency and 🔒 security**</span>

</div>
