class ApplicationController < ActionController::API
  include JsonResolver
  include Exceptions

  rescue_from Exception do |e|
    error(e)
  end

  # 400
  # 파라미터가 잘못됨
  rescue_from Exceptions::BadRequest, ActiveRecord::RecordInvalid do |e|
    exception_handler e, :bad_request
  end

  # 400
  # 파라미터가 잘못됨
  rescue_from ActionController::ParameterMissing do |e|
    e = Exception.new("필수 파라메터가 필요합니다: #{e.param}")
    exception_handler e, :bad_request
  end

  # 400
  # 파라미터가 잘못됨
  rescue_from ArgumentError do |e|
    exception_handler e, :bad_request
  end

  # 401
  # 유효하지 않은 token
  rescue_from Exceptions::Unauthorized do |e|
    exception_handler e, :unauthorized
  end

  # 403
  # 요청 권한 없음
  rescue_from Exceptions::Forbidden do |e|
    exception_handler e, :forbidden
  end

  # 404
  # 존재하지 않음
  rescue_from Exceptions::NotFound do |e|
    exception_handler e, :not_found
  end

  # 404
  # 존재하지 않음
  rescue_from ActiveRecord::RecordNotFound do |e|
    message = Ununiga::JosaPicker.takewell("#{Object.const_get(e.model).model_name.human}가(이) 존재하지 않습니다")
    e = Exception.new(message)

    exception_handler e, :not_found
  end

  # 409
  # 비즈니스 로직에 위배됨
  rescue_from Exceptions::Conflict do |e|
    exception_handler e, :conflict
  end

  # 409
  # 삭제에 실패함
  rescue_from ActiveRecord::RecordNotDestroyed do |e|
    render json: { data: {}, meta: { message: e.record.errors.messages[:base].first } }, status: :conflict
  end

  # 409
  # 유니크키가 중복됨
  rescue_from ActiveRecord::RecordNotUnique do
    exception_handler Exception.new('중복되는 데이터가 존재합니다'), :conflict
  end

  def exception_handler(e, status, error_code = nil)
    meta = {}
    meta[:message] = e.message if e.message
    meta[:error_code] = error_code if error_code

    render json: { data: {}, meta: }, status:
  end

  def error(e)
    Rails.logger.error(e)
    send_newrelic_errors(e)
    meta = { message: '현재 요청사항을 처리할 수 없습니다. 잠시 후 다시 시도해주세요' }

    render json: { data: {}, meta: }, status: :internal_server_error
  end
end
