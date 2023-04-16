# frozen_string_literal: true

module Commands
  class CreateVisit
    def self.call(params)
      new(params).create_visit
    end

    attr_accessor :message, :status
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def create_visit
      date = validate_date!
      member_id = find_member_id
      minutes = params[:minutes]
      rate = params[:rate]
      visit = Visit.new(date:, member_id:, minutes:, rate:)

      if visit.save
        @message = visit
        @status = :created
      else
        @message = visit.errors.full_messages
        @status = :unprocessable_entity
      end

      self
    rescue ActiveRecord::RecordNotFound => e
      @message = e.message
      @status = :not_found
      self
    rescue StandardError => e
      @message = e.message
      @status = :unprocessable_entity
      self
    end

    def find_member_id
      User.find(params[:member_id]).id
    end

    def validate_date!
      date = DateTime.parse(params[:date])
      raise 'date is in the past' unless date.future?

      date
    end
  end
end
