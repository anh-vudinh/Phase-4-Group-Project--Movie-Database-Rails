class ResponseSerializer < ActiveModel::Serializer
  attributes :id, :author, :context, :username, :avatar_path
end
