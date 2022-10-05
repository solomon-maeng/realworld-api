require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => token_generator(user.id) } }
  subject(:invalid_request_obj) { described_class.new({}) }
  subject(:request_obj) { described_class.new(header) }

  describe '#call' do
    context '유효한 요청' do
      it '유저 개체를 반환' do
        result = request_obj.call
        expect(result[:user]).to eq(user)
      end
    end

    context '잘못된 요청' do
      context '토큰 유실' do
        it 'UnAuthorized 에러 발생' do
          expect { invalid_request_obj.call }
            .to raise_error(Exceptions::Unauthorized, '잘못된 인증 요청입니다.')
        end
      end

      context '잘못된 토큰' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end
      end

      context '만료된 토큰' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'UnAuthorized 에러 발생' do
          expect { invalid_request_obj.call }
            .to raise_error(Exceptions::Unauthorized, '잘못된 인증 요청입니다.')
        end
      end

      context '가짜 토큰' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'UnAuthorized 에러 발생' do
          expect { invalid_request_obj.call }
            .to raise_error(Exceptions::Unauthorized, '잘못된 인증 요청입니다.')
        end
      end
    end
  end
end