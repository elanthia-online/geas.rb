module Geas
  module Stream
    def self.on_unhandled(tag)
      #System.log(tag.text || tag, label: %{unhandled_#{tag.name}})
    end

    def self.on_indicator(tag)
      # TODO: update indicators
    end

    def self.on_compass(tag)
      # TODO: update compass
    end
  end
end