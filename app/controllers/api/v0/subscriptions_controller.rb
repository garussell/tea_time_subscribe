class Api::V0::SubscriptionsController < ApplicationController
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
    rescue ActiveRecord::RecordInvalid => e
      render json: ErrorSerializer.format_errors(e.message), status: :bad_request
    end
  end

  def update
    begin
      subscription = Subscription.find(params[:id])
      if subscription.update(status: "inactive")
        render json: SubscriptionSerializer.new(subscription), status: :ok
      else
        render json: { error: ErrorSerializer.format_errors(subscription.errors.full_messages.to_sentence) }, status: :bad_request
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


