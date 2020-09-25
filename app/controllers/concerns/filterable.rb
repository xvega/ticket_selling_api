module Filterable
  extend ActiveSupport::Concern

  def filter_model(klass)
    klass.order(ordering_params(params))
        .page(params[:page] ? params[:page] : 1)
        .per(params[:limit] ? params[:limit] : 10)
  end
end
