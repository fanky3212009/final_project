class Favourite < ActiveRecord::Base
  belongs_to :favourable, polymorphic: true
  belongs_to :users

end
