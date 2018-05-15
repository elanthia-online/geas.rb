require "geas/version"

module Geas
  ## never silently fail
  Thread.report_on_exception = true
  Dir[File.dirname(__FILE__) + "/geis/ext/**/*.rb"].each do |file| require file end
  Dir[File.dirname(__FILE__) + "/geas/**/*.rb"].each do |file| require file end

  def self.link(**opts)
    Geas::Bridge.link(**opts)
    Geas::UI.link()
  end
end
