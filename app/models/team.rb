class Team < ActiveRecord::Base
  EVENTS = %w(all_events lan_gaming_only)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, authentication_keys: [:team_name]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :team_name, :email, :password, :password_confirmation, :remember_me

  validates_presence_of :email, :events

  validates :team_name,
    :presence => true,
    :uniqueness => {
      :case_sensitive => false
    }

  validates_format_of :team_name, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  has_many :members
  belongs_to :captain, class_name: Member

  def get_status
    status? ? 'Active' : 'Inactive'
  end
end