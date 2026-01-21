require 'fastlane_core/ui/ui'
require 'json'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?(:UI)

  module Helper
    class ReactNativeVersionBumpHelper
      def self.get_package_version(path)
        content = JSON.parse(File.read(path))
        content['version']
      end

      def self.update_package_version(path, version)
        content = JSON.parse(File.read(path))
        content['version'] = version
        File.write(path, "#{JSON.pretty_generate(content)}\n")
      end

      def self.bump_version(version, type)
        major, minor, patch = version.split('.').map(&:to_i)
        case type.to_s
        when 'major'
          major += 1
          minor = 0
          patch = 0
        when 'minor'
          minor += 1
          patch = 0
        when 'patch'
          patch += 1
        end
        "#{major}.#{minor}.#{patch}"
      end

      def self.update_android_version(path, version, increment_build)
        gradle_file = File.join(path, 'app', 'build.gradle')
        return unless File.exist?(gradle_file)

        content = File.read(gradle_file)

        if version
          content.gsub!(/versionName\s+["'].*["']/, "versionName \"#{version}\"")
        end

        if increment_build
          content.gsub!(/versionCode\s+(\d+)/) do |_match|
            current_code = Regexp.last_match(1).to_i
            "versionCode #{current_code + 1}"
          end
        end

        File.write(gradle_file, content)
      end

      def self.update_ios_version(path, version, increment_build)
        plist_files = Dir.glob(File.join(path, '**', 'Info.plist'))
        plist_files.each do |plist_path|
          content = File.read(plist_path).force_encoding('UTF-8').scrub('')

          if version
            content.gsub!(%r{<key>CFBundleShortVersionString</key>\s*<string>.*?</string>}m,
                          "<key>CFBundleShortVersionString</key>\n\t<string>#{version}</string>")
          end

          if increment_build
            content.gsub!(%r{<key>CFBundleVersion</key>\s*<string>(\d+)</string>}m) do |_match|
              current_build = Regexp.last_match(1).to_i
              "<key>CFBundleVersion</key>\n\t<string>#{current_build + 1}</string>"
            end
          end

          File.write(plist_path, content)
        end
      end
    end
  end
end
