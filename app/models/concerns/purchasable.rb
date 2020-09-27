module Purchasable
  extend ActiveSupport::Concern

  def available_purchasable(klass, params)
    klass.constantize.available_per_type(params[:purchasable_id])
  end

  def update_quantity(klass, params)
    klass.constantize.update_available_tickets(params[:purchasable_id], params[:purchasable_quantity])
  end

  def calculate_total(klass, params)
    individual_price = klass.constantize.find_price(params[:purchasable_id])
    individual_price * params[:purchasable_quantity]
  end
end
