describe Fastlane::Actions::ReactNativeVersionBumpAction do
  describe '#run' do
    let(:defaults) do
      {
        type: "patch",
        package_json_path: "./package.json",
        ios_path: "./ios",
        android_path: "./android",
        increment_build_number: true
      }
    end

    before do
      allow(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:get_package_version).and_return("1.0.0")
      allow(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:bump_version).and_return("1.0.1")
      allow(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:update_package_version)
      allow(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:update_android_version)
      allow(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:update_ios_version)
      allow(Fastlane::UI).to receive(:message)
      allow(Fastlane::UI).to receive(:success)
    end

    it 'calls the helper methods to get and bump the version' do
      expect(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:get_package_version).with("./package.json")
      expect(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:bump_version).with("1.0.0", "patch")

      Fastlane::Actions::ReactNativeVersionBumpAction.run(defaults)
    end

    it 'updates package.json, android, and ios versions' do
      params = {
        type: "minor",
        package_json_path: "custom/package.json",
        ios_path: "custom/ios",
        android_path: "custom/android",
        increment_build_number: false
      }

      allow(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:bump_version).and_return("1.1.0")

      expect(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:update_package_version).with("custom/package.json", "1.1.0")
      expect(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:update_android_version).with("custom/android", "1.1.0", false)
      expect(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:update_ios_version).with("custom/ios", "1.1.0", false)

      Fastlane::Actions::ReactNativeVersionBumpAction.run(params)
    end

    it 'returns the new version' do
      allow(Fastlane::Helper::ReactNativeVersionBumpHelper).to receive(:bump_version).and_return("1.0.1")
      result = Fastlane::Actions::ReactNativeVersionBumpAction.run(defaults)
      expect(result).to eq("1.0.1")
    end
  end
end
