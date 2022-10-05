require 'rails_helper'

RSpec.describe '사용자 API', type: :request do
  let(:user) { build(:user) }
  let(:headers) { valid_headers.except('Authorization') }
  let(:valid_attributes) do
    attributes_for(:user, password_confirmation: user.password)
  end

  describe 'POST /users/sign-up' do
    context '유효한 요청' do
      before { post '/users/sign-up', params: valid_attributes.to_json, headers: headers }

      it '새로운 유저를 생성한다.' do
        expect(response).to have_http_status(201)
      end

      it '응답 데이터로 인증 토큰을 반환한다.' do
        expect(json['data']).not_to be_nil
      end
    end

    context '잘못된 요청' do
      before {post '/users/sign-up', params: {}, headers: headers}

      it '새로운 유저 생성에 실패한다.' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end