class Car < ApplicationRecord

  belongs_to :user
  belongs_to :manufacturer
  belongs_to :modell
  belongs_to :event

end
