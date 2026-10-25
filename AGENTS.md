# AGENTS.md

Guidance for AI agents working in this repository.

## Project

`console_bars` is a pure Dart package that renders progress bars in the terminal. Its only public API is `FillingBar`, exported from `lib/console_bars.dart`.

Keep the minimum SDK constraint in `pubspec.yaml` (`>=2.14.4 <4.0.0`) in mind: the package language version is 2.14, so do not use newer Dart features (records, patterns, sealed classes, etc.) even though CI runs a current stable SDK.

## Layout

- `lib/console_bars.dart` — library entrypoint and public exports.
- `lib/src/filling_bar.dart` — the `FillingBar` implementation (rendering, timing, percentage, width handling).
- `example/console_bars_example.dart` — runnable demo; keep it working.
- `.github/workflows/publish.yml` — tag-triggered publish and release pipeline.
- `CHANGELOG.md` — release notes, one section per published version.
- `img/` — assets referenced by `README.md`.

## Commands

```bash
dart pub get
dart analyze                              # primary check; must pass
dart run example/console_bars_example.dart
dart pub publish --dry-run                # run before releasing
```

There is no test suite currently. If you add tests, add `test` as a dev dependency and place them under `test/`.

The codebase is not fully formatter-clean (`lib/src/filling_bar.dart` currently differs from `dart format` output). Match the surrounding style and avoid reformatting unrelated lines; keep diffs focused.

## Rendering invariants

Preserve these behaviors when changing `FillingBar`:

- Terminal detection (`stdout.hasTerminal`) happens once in the constructor.
- On a real terminal, frames are rewritten on the same line with `\r`; when stdout is not a terminal, each frame is written on its own line with a trailing newline.
- `_lastFrameLength` pads shorter frames so leftovers from a previous longer frame are erased.
- Width resolves in this order: explicit `width`, then `stdout.terminalColumns * scale`, then the 80-column fallback (`_fallbackWidth`).
- Setting `desc` or `total` triggers an immediate re-render.
- `time: true` starts the stopwatch and schedules `autoRender`; the clock stops when the bar completes.

## Releasing

Publishing is automated by `.github/workflows/publish.yml` and is irreversible. Do not create or push release tags unless the user explicitly asks to publish.

1. Update `version:` in `pubspec.yaml`.
2. Add a `## <version>` section to `CHANGELOG.md`. This is required: `dart pub publish --dry-run` exits with code 65 when the current version is missing, which blocks the pipeline.
3. Commit and push to `master`.
4. Create and push a matching tag:

   ```bash
   git tag v1.4.0
   git push origin v1.4.0
   ```

5. The workflow verifies the tag matches `pubspec.yaml`, analyzes the package, publishes to pub.dev via OIDC (no pub token secret), then creates a GitHub release. The tag must match the pattern `v{{version}}` configured on pub.dev, and the tag and `pubspec.yaml` version must be identical (without the `v`).
