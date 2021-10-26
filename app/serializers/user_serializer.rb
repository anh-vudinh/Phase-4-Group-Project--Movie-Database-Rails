class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :useremail, :avatar_path, :is_admin, :account_active, :password_digest
end
