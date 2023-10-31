class Api::V0::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find_by(id: params[:id])

    if customer.nil?
      render json: ErrorSerializer.format_errors("Customer not found"), status: :not_found
    else
      subscriptions = customer.subscriptions
      render json: SubscriptionSerializer.new(subscriptions), status: :ok
    end
  end
  
  def create
    begin
      customer = Customer.find(params[:subscription][:customer_id])
      subscription = customer.subscriptions.build(subscription_params)

      if subscription.save
        render json: SubscriptionSerializer.new(subscription), status: :created
      else
        render json: ErrorSerializer.format_errors(subscription.errors.full_messages.to_sentence), status: :bad_request
      end
    rescue ActiveRecord::RecordNotFound
      render json: ErrorSerializer.format_errors("Customer not found"), status: :not_found
    end
  end

  def update
    begin
      subscription = Subscription.find(params[:id])
      if subscription.update(status: "cancelled")
        render json: SubscriptionSerializer.new(subscription), status: :ok
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Subscription not found" }, status: :not_found
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:title, :price, :status, :frequency, :customer_id)
  end
end


