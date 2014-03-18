class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  FRONT_COLUMNS = 3

  field :name, type: String
  field :desc, type: String
  field :body, type: String
  field :type, type: String
  field :owner, type: String

  scope :all_with_type, ->(type){ where(type: type) }

  def self.for_front_page(owner = nil)
    if owner == 'admin'
      self.all
    elsif owner
      self.or({ owner: owner }, { owner: nil })
    else
      self.where(owner: nil)
    end
  end

  def typed?(type)
    self.type == type
  end

  def owned_by?(owner)
    self.owner == owner
  end
end
