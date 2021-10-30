class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :useremail, :password_digest, :login_status, :is_admin, :account_active, :avatar_path
end
