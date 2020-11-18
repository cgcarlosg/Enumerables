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
      my_each { |item| result = false unless item.to_s.match(arg) }
    elsif arg.instance_of? Class
      my_each { |item| result = false unless item.is_a? == arg }
    end
    result
  end

  def my_any?(arg = nil)
    result = false
    if block_given? || arg.nil?
      my_each { |item| result = true if yield item }
    elsif arg.is_a? Regexp
      my_each { |item| result = true if item.to_s.match(arg) }
    elsif arg.instance_of? Class
      my_each { |item| result = true if item.is_a? == arg }
    end
    result
  end

  def my_none?(arg = nil)
    result = true
    if block_given? || arg.nil?
      my_each { |item| result = false if yield item }
    elsif arg.is_a? Regexp
      my_each { |item| result = false if item.to_s.match(arg) }
    elsif arg.instance_of? Class
      my_each { |item| result = false if item.is_a? == arg }
    end
    result
  end

  def my_count(arg = nil)
    if arg.nil? && !block_given?
      length
    else
      counter = 0
      my_each do |item|
        counter += 1 if yield item
      end
    end
    counter
  end

  def my_map(proc = nil)
    arr = []
    return to_enum unless block_given?

    if proc
      my_each { |e| arr.push(proc.call(e)) }
    else
      my_each { |e| arr.push(yield(e)) }
    end
    arr
  end

  def my_inject(acc = nil)
    my_each do |e|
      if !acc
        acc = e
      elsif acc.instance_of?(Range)
        my_each { |e| acc += e }
      else
        acc = yield(acc, e)
      end
    end
    acc
  end

  def multiply_els(arr)
    arr.my_inject { |i, j| i * j }
  end
end
