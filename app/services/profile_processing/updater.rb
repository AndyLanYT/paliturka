class ProfileProcessing::Updater < ServiceBase
  attr_reader :profile, :profile_params

  def initialize(profile, profile_params)
    super()

    @profile = profile
    @profile_params = profile_params
  end

  def self.update!(profile, profile_params)
    new(profile, profile_params).update!
  end

  def update!
    return unless @profile

    @profile.update(@profile_params)
    @profile
  end
end
