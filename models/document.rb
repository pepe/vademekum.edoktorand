class Document
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :name, type: String
  field :description, type: String
  field :body, type: String
end
