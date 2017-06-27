class Api::TransactionsController < ApplicationController
  before_action :authenticate_user!
end
