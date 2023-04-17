# frozen_string_literal: true

module Commands
  class CreateUser
    def self.call(params)
      new(params).call
    end

    attr_reader :params
    attr_accessor :message, :status

    def initialize(params)
      @params = params
    end

    def call
      user = User.new(params)

      if user.save
        @message = user
        @status = :created
      else
        @message = user.errors.full_messages
        @status = :unprocessable_entity
      end
      self
    end
  end
end
