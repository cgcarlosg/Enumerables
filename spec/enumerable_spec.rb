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

describe 'my_select' do
    it 'return a new array based on block provided' do
        expect(array.my_select(&:positive?)).to eql([1, 2, 3])
    end
end
=begin
describe '#my_all?' do
it  do
    expect
end
end

describe '#my_any?' do
it  do
    expect
end
end

describe '#my_none?' do
it  do
    expect
end
end

describe '#my_count' do
it  do
    expect
end
end

describe '#my_map' do
it  do
    expect
end
end

describe '#my_inject' do
it  do
    expect
end
end

describe '#multiply_els' do
it  do
    expect
end
end

=end
end