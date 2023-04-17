# frozen_string_literal: true

module Commands
  class FulfillVisit
    def self.call(params)
      new(params).call
    end

    attr_reader :params
    attr_accessor :member, :pal, :visit, :message, :status

    def initialize(params)
      @params = params
    end

    def call
      find_visit!
      find_pal!
      find_member!
      validate_member_account_balance!
      create_member_to_pal_transaction!
      @message = 'visit has been fulfilled and credited to your account'
      @status = :created
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

    private

    def create_member_to_pal_transaction!
      ActiveRecord::Base.transaction do
        Transaction.create!(member: member, pal: pal, amount: visit.cost)
        visit.update!(completed_at: Time.current)

        # debit the cost from the member
        member_balance = member.account.balance
        member.account.update!(balance: member_balance - visit.cost)

        # take out 15%
        pal_credit = visit.cost * 0.85
        # credit the pal
        pal_balance = pal.account.balance
        pal.account.update!(balance: pal_balance + pal_credit)
      end
    end

    def validate_member_account_balance!
      raise 'Member does not have enough credit to pay you for this visit' unless \
        member.account && member.account.balance >= visit.cost
    end

    def find_visit!
      @visit = Visit.find(params[:visit_id])
    end

    def find_pal!
      @pal = User.find(params[:pal_id])
    end

    def find_member!
      @member = visit.member
    end
  end
end
