require 'rails_helper'

RSpec.describe AuthenticateUser do
  let(:user) { create(:user) }
  subject(:valid_auth_obj) { described_class.new(user.email, user.password) }
  subject(:invalid_auth_obj) { described_class.new('foo', 'bar') }

  describe '#call' do
    context '유효한 자격' do
      it '인증 토큰 반환' do
        token = valid_auth_obj.call
        expect(token).not_to be_nil
      end

      context '유효하지 않은 자격' do
        it 'UnAuthorized 에러 발생' do
          expect { invalid_auth_obj.call }
            .to raise_error(Exceptions::Unauthorized, '잘못된 인증 요청입니다.')
        end
      end
    end
  end
end