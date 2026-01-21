# fastlane-plugin-react_native_version_bump

## React Native Version Bump Plugin

| Fastlane Plugin | fastlane-plugin-react_native_version_bump |
| :--- | :--- |
| **Goal** | Automate version bumping for React Native projects across `package.json`, Android, and iOS. |
| **Author** | Flix |
| **Version** | 1.0.0 (Initial Release) |

## Getting Started

This project is a [fastlane](https://fastlane.tools) plugin. To get started with `fastlane-plugin-react_native_version_bump`, add it to your project by running:

```bash
fastlane add_plugin react_native_version_bump
```

## Available Actions

### `react_native_version_bump`

The `react_native_version_bump` action automatically updates the version number in your React Native project's key files:

1.  **`package.json`**: Updates the `version` field based on the specified bump type (`major`, `minor`, or `patch`).
2.  **Android (`android/app/build.gradle`)**: Updates `versionName` to the new semantic version and increments `versionCode`.
3.  **iOS (`ios/**/Info.plist`)**: Updates `CFBundleShortVersionString` to the new semantic version and increments `CFBundleVersion`.

#### Example

```ruby
lane :beta do
  # Bumps the version from 1.0.0 to 1.0.1 (patch is default)
  react_native_version_bump

  # Bumps the version from 1.0.1 to 1.1.0
  react_native_version_bump(
    type: "minor"
  )

  # Bumps the version from 1.1.0 to 2.0.0
  react_native_version_bump(
    type: "major"
  )
end
```

#### Parameters

| Key | Description | Default Value | Type | Optional |
| :--- | :--- | :--- | :--- | :--- |
| `type` | The type of version bump to perform: `major`, `minor`, or `patch`. | `"patch"` | `String` | Yes |
| `package_json_path` | Path to your `package.json` file. | `"./package.json"` | `String` | Yes |
| `ios_path` | Path to your iOS directory (e.g., where your `.xcodeproj` or `.xcworkspace` is located). | `"./ios"` | `String` | Yes |
| `android_path` | Path to your Android directory. | `"./android"` | `String` | Yes |
| `increment_build_number` | Whether to increment the platform-specific build number (`versionCode` for Android, `CFBundleVersion` for iOS). | `true` | `Boolean` | Yes |

## Run Tests for this Plugin

To run the tests for this plugin, you can use [Bundler](https://bundler.io/) and [Rake](https://rake.rubyforge.org/):

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rake spec
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.
