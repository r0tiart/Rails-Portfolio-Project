class GenreSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_many :books
end
