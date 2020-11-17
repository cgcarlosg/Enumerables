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

  def my_select
    arr = []
    if block_given?
      for i in 0..(length - 1)
        yield(self[i]) ? arr.push(self[i]) : false
      end
      return arr
    end
    to_enum
  end

  def my_all?
    for i in 0..(length - 1)
      return false unless yield(self[i])
    end
    true
  end
end