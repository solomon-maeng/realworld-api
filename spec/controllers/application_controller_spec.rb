require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let!(:user) { create(:user) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  describe '#인증 요청' do
    context '인증 토큰이 올바른 경우' do
      before { allow(request).to receive(:headers).and_return(headers) }

      it '현재 유저로 설정.' do
        expect(subject.instance_eval { authorize_request }).to eq user
      end
    end

    context '인증 토큰이 올바르지 않은 경우' do
      before do
        allow(request).to receive(:headers).and_return(invalid_headers)
      end

      it 'UnAuthorized 에러 발생.' do
        expect { subject.instance_eval { authorize_request } }
          .to raise_error(Exceptions::Unauthorized)
      end
    end
  end
end