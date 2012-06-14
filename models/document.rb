class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  FRONT_COLUMNS = 3

  field :name, type: String
  field :desc, type: String
  field :body, type: String
  field :type, type: String

  scope :for_type_page, ->(type){ where(type: type) }

  def self.for_front_page
    self.all
  end

  def is_type?(type)
    self.type == type
  end
end
