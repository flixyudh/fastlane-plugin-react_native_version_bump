require 'fastlane/action'
require 'fastlane_core'
require_relative '../helper/react_native_version_bump_helper'

module Fastlane
  module Actions
    class ReactNativeVersionBumpAction < Action
      def self.run(params)
        type = params[:type]
        package_json_path = params[:package_json_path]
        ios_path = params[:ios_path]
        android_path = params[:android_path]
        increment_build_number = params[:increment_build_number]

        current_version = Helper::ReactNativeVersionBumpHelper.get_package_version(package_json_path)
        new_version = Helper::ReactNativeVersionBumpHelper.bump_version(current_version, type)

        UI.message("Bumping version from #{current_version} to #{new_version} (#{type})")

        Helper::ReactNativeVersionBumpHelper.update_package_version(package_json_path, new_version)
        Helper::ReactNativeVersionBumpHelper.update_android_version(android_path, new_version, increment_build_number)
        Helper::ReactNativeVersionBumpHelper.update_ios_version(ios_path, new_version, increment_build_number)

        UI.success("Successfully bumped version to #{new_version}")
        new_version
      end

      def self.description
        "Auto bump version for React Native projects (package.json, Android, and iOS)"
      end

      def self.authors
        ["Flix"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :type,
                                      env_name: "REACT_NATIVE_VERSION_BUMP_TYPE",
                                      description: "The type of bump (major, minor, patch)",
                                      optional: true,
                                      default_value: "patch",
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :package_json_path,
                                      env_name: "REACT_NATIVE_VERSION_BUMP_PACKAGE_JSON_PATH",
                                      description: "Path to your package.json file",
                                      optional: true,
                                      default_value: "./package.json",
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :ios_path,
                                      env_name: "REACT_NATIVE_VERSION_BUMP_IOS_PATH",
                                      description: "Path to your ios directory",
                                      optional: true,
                                      default_value: "./ios",
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :android_path,
                                      env_name: "REACT_NATIVE_VERSION_BUMP_ANDROID_PATH",
                                      description: "Path to your android directory",
                                      optional: true,
                                      default_value: "./android",
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :increment_build_number,
                                      env_name: "REACT_NATIVE_VERSION_BUMP_INCREMENT_BUILD_NUMBER",
                                      description: "Whether to increment the build number/version code",
                                      optional: true,
                                      default_value: true,
                                      type: [TrueClass, FalseClass])
        ]
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
