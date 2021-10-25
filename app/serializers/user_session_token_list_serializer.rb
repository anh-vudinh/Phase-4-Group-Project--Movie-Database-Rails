class UserSessionTokenListSerializer < ActiveModel::Serializer
  attributes :id, :session_token, :session_duration, :exp_end
  has_one :user
end
