require_relative 'archives'

class ArchivesCreator
  # @return [Archives]
  def self.create
    Archives.new(Archives::Env.new)
  end

  def self.create_android
    AndroidArchives.new(Archives::Env.new)
  end

  def self.create_ios
    IOSArchives.new(Archives::Env.new)
  end
end
