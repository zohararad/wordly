module Wordly
  class Settings

    def self.method_missing(method, *args)
      m = method.to_s
      if Wordly::CONFIG.keys.include? m
        Wordly::CONFIG[m]
      else
        super
      end
    end

  end
end