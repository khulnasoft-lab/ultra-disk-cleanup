Here’s a complete `README.md` for your **Ultra Disk Cleanup** GitHub Action — optimized for the GitHub Marketplace and developers using large CI builds.

---

```markdown
# 🧼 Ultra Disk Cleanup

![GitHub Action](https://img.shields.io/badge/action-ultra--disk--cleanup-red?logo=github&style=for-the-badge)
![Disk Cleanup](https://img.shields.io/badge/cleans-up%20to-30+GB-success?style=for-the-badge)

Aggressively free up disk space on GitHub-hosted Ubuntu runners. Ideal for CI builds that need extra room (e.g., mobile builds, container builds, ML workflows).

---

## 🚀 Features

- 🧹 Deletes Android, Docker, GHC, Rust, .NET, and more
- 💨 Clears swap, temp files, logs, locale, man, and docs
- 🐳 Removes all Docker images and prunes cache
- 🔍 Finds and deletes all files >100MB outside `/proc` and `/sys`
- 📈 Outputs disk space saved in bytes

---

## 📦 Usage

```yaml
- name: Run Ultra Disk Cleanup
  uses: khulnasoft-lab/ultra-disk-cleanup@v1
  with:
    debug: true
```

### Inputs

| Name   | Required | Default | Description              |
|--------|----------|---------|--------------------------|
| debug  | false    | false   | Print debug information  |

### Outputs

| Name         | Description                      |
|--------------|----------------------------------|
| saved-space  | Disk space saved (in bytes)      |

---

## 🧪 Example Workflow

```yaml
name: Cleanup CI

on: [push]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: 🧼 Cleanup
        uses: khulnasoft-lab/ultra-disk-cleanup@v1
        with:
          debug: true

      - name: Print saved space
        run: echo "Disk saved: ${{ steps.cleanup.outputs.saved-space }} bytes"
```

---

## 📊 Typical Results

| Runner          | Space Reclaimed |
|-----------------|------------------|
| `ubuntu-latest` | 20–35 GB         |

---

## 🛡️ Disclaimer

This action performs **aggressive deletions**. Use it only on CI runners — not on production servers. Always test thoroughly.

---

## 🤝 Contributing

Pull requests are welcome! If you find issues or want to optimize cleanup even more, please open an issue or PR.

---

## 📄 License

[MIT](LICENSE)

---

> Developed with ❤️ by [khulnasoft-lab](https://github.com/khulnasoft-lab)
```

---

Would you like:

- A **markdown badge preview** (for GitHub Marketplace)?
- A **GIF** showing disk space before and after?
- To **auto-generate a `LICENSE` and `release.yml`** for this Action?

Let me know!
