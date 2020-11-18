# rubocop:disable Style/For

module Enumerable
  def my_each
    block_given? ? size.times { |i| yield(to_a[i]) } : to_enum
    self
  end

  def my_each_with_index
    block_given? ? size.times { |i| yield(to_a[i], i) } : to_enum
    self
  end

  def my_select
    arr = []
    block_given? ? my_each { |e| arr.push(e) if yield(e) } : to_enum
    arr
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
