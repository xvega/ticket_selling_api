module Orderable
  extend ActiveSupport::Concern

  # GET /v1/tickets?sort=-name,-age
  # ordering_params(params) # => { name: :desc}
  # Ticket.order(name: :desc)
  # default sort attribute name
  def ordering_params(params)
    ordering = {}
    sort_params = params[:sort].nil? ? '-name' : params[:sort]

    if sort_params
      sort_order = { '+' => :asc, '-' => :desc }

      sorted_params = sort_params.split(',')
      sorted_params.each do |attr|
        sort_sign = (attr =~ /\A[+-]/) ? attr.slice!(0) : '+'
        model = controller_name.classify.constantize
        if model.attribute_names.include?(attr)
          ordering[attr] = sort_order[sort_sign]
        end
      end
    end
    ordering
  end
end
