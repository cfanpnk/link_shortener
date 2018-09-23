class Stat < ApplicationRecord
  def increase_counter
    self.count += 1 
    self.save
  end
end
