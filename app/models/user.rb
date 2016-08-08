class User < CuentaBase
  has_many :comments, dependent: :delete_all
  has_many :entries, dependent: :delete_all
  has_many :events, through: :entries
end
