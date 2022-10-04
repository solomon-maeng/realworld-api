
module JsonResolver
  extend ActiveSupport::Concern

  def json_success(data = {}, meta = {}, status = 200)
    meta = { message: meta } if meta.is_a?(String)

    render json: { data:, meta: }, status:
  end

  def json_create_success(data = {}, meta = {})
    json_success(data, meta, 201)
  end
end