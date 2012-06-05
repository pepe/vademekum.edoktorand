class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  FRONT_COLUMNS = 2

  field :name, type: String
  field :desc, type: String
  field :body, type: String
  field :type, type: String

  def self.for_front_page
    docs = self.all
    in_column = docs.size / FRONT_COLUMNS
    in_column += 1 if docs.size % FRONT_COLUMNS != 0
    docs.each_slice(in_column)
  end
end
