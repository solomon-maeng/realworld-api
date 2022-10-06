require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let(:user) { create(:user) }
  let!(:article) { create(:article, user_id: user.id) }
  let!(:comments) { create_list(:comment, 20, article_id: article.id, user_id: user.id) }
  let(:article_id) { article.id }
  let(:id) { comments.first.id }
  let(:headers) { valid_headers }

  describe 'GET /articles/:article_id/comments' do
    before { get "/articles/#{article_id}/comments", params: {}, headers: headers }

    context '게시글이 존재한다면,' do
      it '응답 코드 200 반환.' do
        expect(response).to have_http_status(:ok)
      end

      it '게시글에 대한 모든 댓글 반환.' do
        expect(json['data'].size).to eq 20
      end
    end

    context '게시글이 존재하지 않는다면,' do
      let(:article_id) { 0 }

      it '응답 코드 404 반환.' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'GET /articles/:article_id/comments/:id' do
    before { get "/articles/#{article_id}/comments/#{id}", params: {}, headers: headers }

    context '게시글에 댓글이 존재한다면,' do
      it '응답 코드 200 반환.' do
        expect(response).to have_http_status(:ok)
      end

      it '댓글을 반환.' do
        expect(json['data']['id']).to eq id
      end
    end

    context '게시글에 댓글이 존재하지 않는다면,' do
      let(:id) { 0 }

      it '응답 코드 404 반환.' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /articles/:article_id/comments' do
    let(:valid_attributes) { { body: 'hello comments' }.to_json }

    context '요청이 유효하다면,' do
      before do
        post "/articles/#{article_id}/comments", params: valid_attributes, headers: headers
      end

      it '응답 코드 201 반환.' do
        expect(response).to have_http_status(:created)
      end
    end

    context '요청이 유효하지 않다면,' do
      before { post "/articles/#{article_id}/comments", params: {}, headers: headers }

      it '응답 코드 400 반환.' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PUT /articles/:article_id/comments/:id' do
    let(:valid_attributes) { { body: 'hello comments' }.to_json }

    before do
      put "/articles/#{article_id}/comments/#{id}", params: valid_attributes, headers: headers
    end

    context '댓글이 존재한다면,' do
      it '응답 코드 204 반환.' do
        expect(response).to have_http_status(:no_content)
      end

      it '댓글을 수정한다.' do
        updated_comment = Comment.find(id)
        expect(updated_comment.body).to match 'hello comments'
      end
    end

    context '댓글이 존재하지 않는다면,' do
      let(:id) { 0 }

      it '응답 코드 404 반환.' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'DELETE /articles/:id' do
    before { delete "/articles/#{article_id}/comments/#{id}", params: {}, headers: headers }

    it '응답 코드 204 반환.' do
      expect(response).to have_http_status(:no_content)
    end
  end
end
