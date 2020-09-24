module Response
  def json_response(object, status: :ok, meta: {})
    render json: object, meta: meta, status: status
  end
end
