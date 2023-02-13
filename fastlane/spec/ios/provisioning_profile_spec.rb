require_relative '../../system/shipping'
require_relative '../../build/ios/provisioning_profile'

describe Build::IOS::ProvisioningProfile do
  before(:each) do
    @provisioning_profile = Build::IOS::ProvisioningProfile.new(
      'dev_provisioning_profile',
      'staging_provisioning_profile',
      'production_provisioning_profile'
    )
  end

  it 'dev環境のプロビジョニングプロファイルを取得した際' do
    profile_name = @provisioning_profile.get(System::Shipping::DEV)
    expect(profile_name).to eq 'dev_provisioning_profile'
  end

  it 'staging環境のプロビジョニングプロファイルを取得した際' do
    profile_name = @provisioning_profile.get(System::Shipping::STAGING)
    expect(profile_name).to eq 'staging_provisioning_profile'
  end

  it 'production環境のプロビジョニングプロファイルを取得した際' do
    profile_name = @provisioning_profile.get(System::Shipping::PRODUCTION)
    expect(profile_name).to eq 'production_provisioning_profile'
  end
end
