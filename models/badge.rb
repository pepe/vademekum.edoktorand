class Badge
  include Mongoid::Document

  field :name, type: String
  field :awarded_at, type: Time

  embedded_in :account
end
