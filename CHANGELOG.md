## 0.1.0-alpha.0

- Initial version.

## 1.0.0

- Added support for %
- First stable build

## 1.0.1

- Added gif in readme

## 1.0.2

- Updated readme

## 1.0.3

- Added description

## 1.0.4

- Fixed "Cant read terminal width" error

## 1.0.5

- More documentation

## 1.1.0

- Fixed [issue #4](https://github.com/RohitEdathil/ConsoleBars/issues/4)

## 1.2.0

- Fixed [issue #5](https://github.com/RohitEdathil/ConsoleBars/issues/5)

- `total` and `desc` are now setters, updating them will change the total number of steps and description mid-way.

## 1.2.1

- Fixed [issue #6](https://github.com/RohitEdathil/ConsoleBars/issues/6)

## 1.3.0

- Fall back to 80 columns when the terminal width is unavailable (e.g. in CI, redirected output, or the VS Code debug console).

- Erase leftovers when a rendered frame gets shorter.

- Use a newline instead of a carriage return when stdout is not a terminal.

- Relicensed under the MIT license.
