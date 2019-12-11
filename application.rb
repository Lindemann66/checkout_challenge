require 'bundler'
require 'yaml'
require 'logger'

module Application

  def self.root
    @root ||= File.expand_path('..', __FILE__)
  end

  def self.env
    @env = ENV['RUBY_ENV'] || 'development'
  end

  def self.settings
    @settings ||= YAML.load_file(File.join(root, 'config', 'settings.yml'))[env]
  end

  def self.logger
    @logger ||= begin
      logger = Logger.new(File.join(root, 'log', "#{ env }.log"))
      logger.datetime_format = "%Y-%m-%d %H:%M:%S.%L %Z "
      logger
    end
  end
end

Bundler.require(:default, Application.env)

Dir[File.join(File.dirname(__FILE__), 'lib/**/*.rb')].each {|f| require f}
Dir[File.join(File.dirname(__FILE__), 'app/domain/**/*.rb')].each {|f| require f}
