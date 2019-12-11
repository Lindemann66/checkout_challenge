require_relative './application'

module Supermarket
  def self.items_meta
    Application.settings['items_meta']
  end
end

if __FILE__ == $0
  Application.logger.info 'Supermarket opens'
  binding.pry
end
