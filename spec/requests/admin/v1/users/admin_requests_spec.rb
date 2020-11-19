
# get
# testar se retornou 200
# testar se retornou 1 user
# testar se retornou erro ao informar id incorreto

# delete
# testar se diminuiu quantidade de user do banco em 1
# testar se retornou erro ao informar id incorreto
# testar se retornou 204 (no_content)

require 'rails_helper'

RSpec.describe "Admin V1 Users as :admin", type: :request do
  let(:userAuth) { create(:user) }

  context 'GET /users' do
    let(:url) { '/admin/v1/users' }

    it 'returns all Users' do
      get url, headers: auth_header(userAuth)
      expect(body_json['users']).to contain_exactly(userAuth.as_json(only: %i[id name email profile]))
    end

    it 'returns success status' do
      get url, headers: auth_header(userAuth)
      expect(response).to have_http_status(:ok)
    end
  end

  context 'POST /users' do
    let(:url) { '/admin/v1/users' }

    context 'with valid params' do
      let(:user_params) { { user: attributes_for(:user) }.to_json }

      it 'adds a new User' do
        expect do
          post url, headers: auth_header(userAuth), params: user_params
        end.to change(User, :count).by(2) # 2 porque na linha 23 agt cria um usuário para a autenticação
      end

      it 'returns last added User' do
        post url, headers: auth_header(userAuth), params: user_params
        expected_user = User.last.as_json(only: %i[id name email profile password])
        expect(body_json['user']).to eq expected_user
      end

      it 'returns success status' do
        post url, headers: auth_header(userAuth), params: user_params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid params' do
      let(:user_invalid_params) do
        { user: attributes_for(:user, email: nil) }.to_json
      end

      it 'does not add a new User' do
        expect do
          post url, headers: auth_header(userAuth), params: user_invalid_params
        end.to change(User, :count).by(1)  # 1 porque na linha 23 agt cria um usuário para a autenticação
      end

      it 'returns error message' do
        post url, headers: auth_header(userAuth), params: user_invalid_params
        expect(body_json['errors']['fields']).to have_key('email')
      end

      it 'returns unprocessable_entity status' do
        post url, headers: auth_header(userAuth), params: user_invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end    
    end
  end

  context 'PATCH /users' do
    let(:url) { "/admin/v1/users/#{userAuth.id}" }

    context 'with valid params' do
      let(:new_name) { 'Gabriel Grazionale' }
      let(:user_params) { { user: { name: new_name } }.to_json }

      it 'updates User' do
        patch url, headers: auth_header(userAuth), params: user_params
        userAuth.reload
        expect(userAuth.name).to eq new_name
      end  

    end
  end

  context "DELETE /users/:id" do
    let!(:user) { create(:user) }
    let(:url) { "/admin/v1/users/#{user.id}" }

    it 'removes User' do
      expect do  
        delete url, headers: auth_header(userAuth)
      end.to change(User, :count).by(0)
    end  
    
    it 'returns success status' do
      delete url, headers: auth_header(userAuth)
      expect(response).to have_http_status(:no_content)
    end  
    
    it 'does not return any body content' do
      delete url, headers: auth_header(userAuth)
      expect(body_json).to_not be_present
    end
  end  
end
