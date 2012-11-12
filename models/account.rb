class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :login, type: String
  field :name, type: String
  field :role, type: String

  def admin?
    self.role == 'admin'
  end
end

