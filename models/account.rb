class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :login, type: String
  field :name, type: String
  field :role, type: String

  embeds_many :badges

  def has_badge?(badge)
    self.badges.where(name: badge).exists?
  end

  def add_badge(badge)
    self.badges.create(name: badge, awarded_at: Time.now)
  end

  def admin?
    self.role == 'admin'
  end
end

