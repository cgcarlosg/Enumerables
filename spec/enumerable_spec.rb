require_relative '../enumerables'

describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:hash) { { 'a' => 'enum', 'b' => 'module', 'c' => 'spec' } }

  describe '#my_each' do
    it 'return each value in an array' do
      i = 0
      array.my_each do |item|
        expect(item).to eql(array[i])
        i += 1
      end
    end

    it 'return each value in a hash' do
      hash.my_each do |key, value|
        expect(value).to eql(hash[key])
      end
    end
  end

  describe '#my_each_with_index' do
    it 'returns a value from an index in an array' do
      i = 0
      array.my_each_with_index do |value, index|
        expect(index).to eql(i)
        expect(value).to eql(array[i])
        i += 1
      end
    end
  end

  describe '#my_select' do
    it 'return a new array based on block provided' do
      expect(array.my_select(&:positive?)).to eql([1, 2, 3])
    end

    it 'return a new hash based on block provided' do
      expect(hash.my_select { |_key, value| value == 'enum' }).to eql([%w[a enum]])
    end
  end

  describe '#my_all?' do
    it 'return true if all elements meet block given' do
      expect(array.my_all? { |num| num == 1 }).to eql(false)
      expect(hash.my_all? { |_key, value| value == 'enum' }).to eql(false)
    end

    it 'return false if one element does not meet block given' do
      expect(array.my_all? { |num| num.is_a? Numeric }).to eql(true)
      expect(hash.my_all? { |value| value.is_a? Enumerable }).to eql(true)
    end
  end

  describe '#my_any?' do
    it 'return true if any element meets block given' do
      expect(array.my_any? { |num| num.even? }).to eql(true)
      expect(hash.my_any? { |_key, value| value == 'enum' }).to eql(true)
    end

    it 'return false if no element meets block given' do
      expect(array.my_any? { |num| num == 4 }).to eql(false)
      expect(hash.my_any? { |_key, value| value == 'hello' }).to eql(false)
    end
  end

  describe '#my_none?' do
    it 'return true if no element meets block given' do
      expect(array.my_none? { |num| num == 0 }).to eql(true)
      expect(hash.my_none? { |_key, value| value == 0 }).to eql(true)
    end

    it 'return false if any element meets block given' do
      expect(array.my_none? { |num| num == 1 }).to eql(false)
      expect(hash.my_none? { |_key, value| value == 'enum' }).to eql(false)
    end
  end

  # describe '#my_count' do
  # it  do
  #     expect
  # end
  # end
  #
  # describe '#my_map' do
  # it  do
  #     expect
  # end
  # end
  #
  # describe '#my_inject' do
  # it  do
  #     expect
  # end
  # end
  #
  # describe '#multiply_els' do
  # it  do
  #     expect
  # end
  # end
  #
end
