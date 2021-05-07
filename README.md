# Swift Concurrency Example

An example illustrating the current state of the upcoming Swift concurrency features.

> ⚠️ Latest Swift toolchain required! Please make sure to install the latest `main` toolchain
> from [swift.org](https://swift.org), or [run this example using Docker](#run-in-docker).

## Run locally

Install the latest toolchain and select it in your Terminal:

```bash
export TOOLCHAINS="Swift Development Snapshot"
# On macOS ...
export DYLD_LIBRARY_PATH=/Library/Developer/Toolchains/swift-latest.xctoolchain/usr/lib/swift/macosx
```

> ⚠️ [macOS: Disable SIP]: For `DYLD_LIBRARY_PATH` to get passed to `swift`, you also need to temporarily
> [disable system integrity protection (SIP)](https://developer.apple.com/documentation/security/disabling_and_enabling_system_integrity_protection).

## Run in Docker

```bash
docker build -t concurrency-playground .
docker run --rm concurrency-playground:latest
```
