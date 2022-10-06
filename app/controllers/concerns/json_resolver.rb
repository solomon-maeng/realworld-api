
module JsonResolver
  extend ActiveSupport::Concern

  def json_success(data = {}, meta = {}, status = :ok)
    meta = { message: meta } if meta.is_a?(String)

    render json: { data:, meta: }, status:
  end

  def json_create_success(data = {}, meta = {})
    json_success(data, meta, :created)
  end
end