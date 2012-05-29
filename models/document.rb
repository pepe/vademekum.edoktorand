class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :description, type: String
  field :body, type: String
  field :types, type: Array, default: []

end
