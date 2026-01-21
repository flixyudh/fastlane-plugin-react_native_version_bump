# Design: Fastlane Plugin for React Native Version Bumping

## Objective
Automate the version bumping process for React Native projects across `package.json`, iOS (`Info.plist` or Xcode project), and Android (`build.gradle`).

## Strategy
1. **Single Source of Truth**: The `package.json` file will be the primary source for the version string.
2. **Version Types**:
   - `major`: Increment the major version (e.g., 1.2.3 -> 2.0.0).
   - `minor`: Increment the minor version (e.g., 1.2.3 -> 1.3.0).
   - `patch`: Increment the patch version (e.g., 1.2.3 -> 1.2.4).
3. **Build Number**: Automatically increment the build number (iOS `CFBundleVersion` and Android `versionCode`).

## Implementation Details
### Action: `react_native_version_bump`
- **Parameters**:
  - `type`: `major`, `minor`, `patch` (default: `patch`).
  - `package_json_path`: Path to `package.json` (default: `./package.json`).
  - `ios_path`: Path to iOS project (default: `./ios`).
  - `android_path`: Path to Android project (default: `./android`).
  - `increment_build_number`: Boolean (default: `true`).

### Workflow
1. Read current version from `package.json`.
2. Calculate new version based on `type`.
3. Update `package.json` with the new version.
4. Update Android:
   - Find `versionName` and `versionCode` in `app/build.gradle`.
   - Update `versionName` to the new version.
   - Increment `versionCode`.
5. Update iOS:
   - Use `agvtool` or modify `Info.plist` / `.pbxproj`.
   - Update `CFBundleShortVersionString` to the new version.
   - Increment `CFBundleVersion`.

## Helper Methods
- `get_package_version(path)`
- `update_package_version(path, version)`
- `update_android_version(path, version, increment_build)`
- `update_ios_version(path, version, increment_build)`
