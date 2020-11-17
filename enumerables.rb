# rubocop:disable Style/For

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

  def my_any?
    result = false
    my_each do |item|
      result = true if yield item
    end
    result
  end

  def my_none?
    result = true
    my_each do |item|
      result = false if yield item
    end
    result
  end

  def my_count
    count = 0
    for i in 0..(length - 1)
      count += 1 if yield(self[i])
    end
    count
  end

  def my_map(proc = nil)
    arr = []
    for i in 0..(length - 1)
      proc ? arr.push(proc.call(self[i])) : arr.push(yield(self[i]))
    end
    arr
  end

  def my_inject
    result = first
    my_each_with_index do |item, index|
      result = yield(result, item) if index.positive?
    end
    result
  end

  def multiply_els(arr)
    arr.my_inject { |result, item| result * item }
  end
end

# rubocop:enable Style/For
