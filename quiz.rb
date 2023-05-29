require 'singleton'

module Quiz
  class << self
    include Singleton

    attr_accessor :yaml_dir, :in_ext, :answers_dir

    def config
      yield self if block_given?
    end
  end
end
