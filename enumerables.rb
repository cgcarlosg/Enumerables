# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity

module Enumerable
  def my_each
    block_given? ? size.times { |i| yield(to_a[i]) } : (return to_enum)
    self
  end

  def my_each_with_index
    block_given? ? size.times { |i| yield(to_a[i], i) } : (return to_enum)
    self
  end

  def my_select
    arr = []
    block_given? ? my_each { |e| arr.push(e) if yield(e) } : (return to_enum)
    arr
  end

  def my_all?(arg = nil)
    if block_given?
      my_each { |e| return false unless yield(e) }
    elsif arg.is_a? Regexp
      my_each { |e| return false unless e.to_s =~ arg }
    elsif arg.is_a? Class
      my_each { |e| return false unless e.is_a? arg }
    elsif arg
      my_each { |e| return false unless e == arg }
    else
      return true
    end
    true
  end

  def my_any?(arg = nil)
    if block_given?
      my_each { |e| return true if yield(e) }
    elsif arg.is_a? Regexp
      my_each { |e| return true if e.to_s =~ arg }
    elsif arg.is_a? Class
      my_each { |e| return true if e.is_a? arg }
    elsif arg
      my_each { |e| return true if e == arg }
    else
      my_each { |e| return true if e }
    end
    false
  end

  def my_none?(arg = nil)
    if block_given?
      my_each { |e| return false if yield(e) }
    elsif arg.is_a? Regexp
      my_each { |e| return false if e.to_s =~ arg }
    elsif arg.is_a? Class
      my_each { |e| return false if e.is_a? arg }
    elsif arg
      my_each { |e| return false if e == arg }
    else
      my_each { |e| return false if e }
    end
    true
  end

  def my_count(arg = nil)
    if arg.nil? && !block_given?
      size
    elsif block_given?
      counter = 0
      my_each do |item|
        counter += 1 if yield item
      end
      counter
    else
      arg_selected = my_select { |item| item == arg }
      arg_selected.size
    end
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
        my_each { |i| acc += i }
      else
        acc = yield(acc, e)
      end
    end
    acc
  end
end

def multiply_els(arr)
  arr.my_inject { |i, j| i * j }
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
