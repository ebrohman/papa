# frozen_string_literal: true

module Commands
  class Result
    attr_reader :message, :status

    def initialize(message:, status:)
      @message = message
      @status = status
    end
  end
end
