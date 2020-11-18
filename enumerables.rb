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

  def my_all?(arg = nil)
    result = true
    if block_given? || arg.nil?
      my_each { |item| result = false unless yield item }
    elsif arg.is_a? Regexp
      my_each { |item|  result = false unless item.to_s.match(arg) }
    else arg.instance_of? Class
      my_each { |item|  result = false unless item.is_a? == arg}
    end
    result
    end

  def my_any?(arg = nil)
    result = false
    if block_given? || arg.nil?
      my_each { |item| result = true if yield item }
    elsif arg.is_a? Regexp
      my_each { |item|  result = true if item.to_s.match(arg) }
    else arg.instance_of? Class
      my_each { |item|  result = true if item.is_a? == arg}
    end
    result
    end


  def my_none?(arg = nil)
    result = true
    if block_given? || arg.nil?
      my_each { |item| result = false if yield item }
    elsif arg.is_a? Regexp
      my_each { |item|  result = false if item.to_s.match(arg) }
    else arg.instance_of? Class
      my_each { |item|  result = false if item.is_a? == arg}
    end
    result
    end

  def my_count(arg = nil)
    if arg.nil? && !block_given?
      self.length
    else
    counter = 0
    my_each do |item| 
      counter += 1 if yield item
    end
  end
    counter
  end

  def my_map
    if block_given?
    finalarray = []
    my_each do |item|
      finalarray.push(yield item)
    end
    finalarray
  else
    to_enum(:my_map)
  end
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
