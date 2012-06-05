class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :desc, type: String
  field :body, type: String
  field :type, type: String

  def self.for_front_page(columns=3)
    docs = self.all
    in_column = docs.size / columns
    in_column += 1 if docs.size % columns != 0
    docs.each_slice(in_column)
  end
end
