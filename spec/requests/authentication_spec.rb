require 'rails_helper'

RSpec.describe '인증', type: :request do
  describe 'POST /users/sign-in' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }.to_json
    end
    let(:invalid_credentials) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }.to_json
    end

    context '요청이 유효하면' do
      before { post '/users/sign-in', params: valid_credentials, headers: headers }

      it '인증 토큰을 반환한다.' do
        expect(response).to have_http_status(:ok)
        expect(json['data']).not_to be_nil
      end
    end

    context '요청이 유효하지 않으면' do
      before { post '/users/sign-in', params: invalid_credentials, headers: headers }

      it '에러 메세지를 반환한다.' do
        expect(response).to have_http_status(:unauthorized)
        expect(json['message']).to be_nil
      end
    end
  end
end