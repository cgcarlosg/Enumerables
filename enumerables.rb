module Enumerable
  def my_each
    for i in 0..(length - 1)
      yield(self[i])
    end
    self
  end

  def my_each_with_index
    i = 0
    until i == size
      yield(self[i], i)
      i += 1
    end
    self
  end
  
end