class UserSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :campaigns_list

end
