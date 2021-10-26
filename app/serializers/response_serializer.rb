class ResponseSerializer < ActiveModel::Serializer
  attributes :id, :author, :content, :username, :avatar_path, :created_at, :updated_at
end
