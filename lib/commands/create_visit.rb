# frozen_string_literal: true

module Commands
  class CreateVisit
    def self.call(params)
      new(params).call
    end

    attr_accessor :message, :status, :member
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      validate_date!
      find_member!
      validate_member_account_balance!
      create_visit
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

    def create_visit
      visit = Visit.new(date: params[:date],
                        member_id: member.id,
                        minutes: params[:minutes],
                        rate: params[:rate])

      if visit.save
        @message = visit
        @status = :created
      else
        @message = visit.errors.full_messages
        @status = :unprocessable_entity
      end

      self
    end

    private

    def validate_member_account_balance!
      raise 'Not enough credit to request a visit' unless \
        member.account && member.account.balance >= (params[:minutes] * params[:rate])
    end

    def find_member!
      @member = User.find(params[:member_id])
    end

    def validate_date!
      date = DateTime.parse(params[:date])
      raise 'date is in the past' unless date.future?
    end
  end
end
