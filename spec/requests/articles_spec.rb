require 'rails_helper'

RSpec.describe 'Articles API', type: :request do
  let(:user) { create(:user) }
  let!(:articles) { create_list(:article, 10, user_id: user.id) }
  let(:article_id) { articles.first.id }
  let(:headers) { valid_headers }

  describe 'GET /articles' do
    before { get '/articles', params: {}, headers: headers }

    it '게시글 목록 반환.' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq 10
    end

    it '응답 코드 200 반환.' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /articles/:id' do
    before { get "/articles/#{article_id}", params: {}, headers: headers }

    context '게시글이 존재한다면,' do
      it '게시글을 단 건 반환.' do
        expect(json).not_to be_empty
        expect(json['data']['id']).to eq article_id
      end

      it '응답 코드 200 반환.' do
        expect(response).to have_http_status(:ok)
      end
    end

    context '게시글이 존재하지 않는다면,' do
      let(:article_id) { 100 }

      it '응답 코드 404 반환.' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /articles' do
    let(:valid_attributes) do
      { title: 'test1', description: 'test1', body: 'test body', slug: 'test1' }.to_json
    end

    context '요청이 유효하다면,' do
      before { post '/articles', params: valid_attributes, headers: headers }

      it '게시글을 생성한다.' do
        expect(json['data']['title']).to eq 'test1'
      end

      it '응답 코드 201 반환' do
        expect(response).to have_http_status(:created)
      end
    end

    context '요청이 유효하지 않다면,' do
      let(:invalid_attributes) { { title: nil }.to_json }

      before { post '/articles', params: invalid_attributes, headers: headers }

      it '응답 코드 400 반환' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT /articles/:id' do
    let(:valid_attributes) do
      { title: 'test1', description: 'test1', body: 'test body', slug: 'test1' }.to_json
    end

    context '게시글이 존재한다면,' do
      before { put "/articles/#{article_id}", params: valid_attributes, headers: headers }

      it '게시글이 수정된다.' do
        expect(response.body).to be_empty
      end

      it '응답 코드 204 반환.' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /articles/:id' do
    before { delete "/articles/#{article_id}", headers: headers }

    it '응답 코드 204 반환.' do
      expect(response).to have_http_status(204)
    end
  end
end
