# frozen_string_literal: true

module V1
  class TransactionsController < ApplicationController
    api :GET, '/v1/transactions', 'List transactions'

    def index
      render json: Transaction.all
    end
  end
end
