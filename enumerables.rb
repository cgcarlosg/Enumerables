module Enumerable
  def my_each
    for i in 0..(length - 1)
      yield(self[i])
    end
    self
  end

  
end