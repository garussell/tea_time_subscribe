class SerializedResults
  include JSONAPI::Serializer

  set_type :tea

  attributes :title, :description, :image, :link
end