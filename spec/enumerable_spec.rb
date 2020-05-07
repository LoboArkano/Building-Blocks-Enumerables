# rubocop:disable Layout/LineLength
require_relative '../main.rb'

describe Enumerable do
  describe '#my_each' do
    let(:arr_num) { [1, 2, 5, 4] }
    let(:arr_str) { %w[a b c] }
    let(:my_hash) { { min: 2, max: 5 } }

    it 'Print all the numbers' do
      expect { arr_num.my_each { |n| print n } }.to output('1254').to_stdout
    end
    it 'Print all the characters' do
      expect { arr_str.my_each { |c| print c, ' -- ' } }.to output('a -- b -- c -- ').to_stdout
    end
    it 'Puts all the keys and his values' do
      expect { my_hash.my_each { |key, value| puts "k: #{key}, v: #{value}" } }.to output("k: min, v: 2\nk: max, v: 5\n").to_stdout
    end
    it 'Reurn enumerator when no block is given' do
      expect(arr_num.my_each).to be_an Enumerator
    end
  end
  describe '#my_each_with_index' do
    let(:arr_num) { [11, 22, 31, 224, 44] }
    let(:arr_str) { %w[cat dog wombat] }
    it 'Puts the index of the numbers less than 30' do
      expect { arr_num.my_each_with_index { |item, index| puts "index: #{index} for #{item}" if item < 30 } }.to output("index: 0 for 11\nindex: 1 for 22\n").to_stdout
    end
    it 'Insert key with an index as a value' do
      my_hash = {}
      arr_str.my_each_with_index { |item, index| my_hash[item] = index }
      expect(my_hash).to include('cat' => 0, 'dog' => 1, 'wombat' => 2)
    end
    it 'Reurn enumerator when no block is given' do
      expect(arr_num.my_each_with_index).to be_an Enumerator
    end
  end
  describe '#my_select' do
    let(:arr_num) { [1, 2, 3, 4, 5] }
    let(:range) { (1..10) }
    let(:arr_sym) { %i[foo bar] }
    it 'Select the even numbers' do
      expect(arr_num.my_select { |num| num <= 3 }).to include(1, 2, 3)
    end
    it 'Select the multiples of three' do
      expect(range.my_select { |i| (i % 3).zero? }).to include(3, 6, 9)
    end
    it 'Select the foo symbol' do
      expect(arr_sym.my_select { |x| x == :foo }).to eql([:foo])
    end
    it 'Reurn enumerator when no block is given' do
      expect(arr_num.my_select).to be_an Enumerator
    end
  end

  let(:arr_bool) { [true, true, false] }
  let(:arr_string) { %w[ant bear bat] }
  let(:arr_mix) { ['ant', 'bear', 8] }
  let(:arr_eight) { [8, 8, 8] }
  let(:arr_n_mix) { [8, 7, 6] }
  describe '#my_all?' do
    it 'Return false if at least one boolean is false' do
      expect(arr_bool.my_all?).to eql(false)
    end
    it 'Return true if all items are string' do
      expect(arr_string.my_all?(String)).to eql(true)
    end
    it 'Return false if at least one item is not a string' do
      expect(arr_mix.my_all?(String)).to eql(false)
    end
    it 'Return true if all items are eight' do
      expect(arr_eight.my_all?(8)).to eql(true)
    end
    it 'Return false if at least one item is different from eight' do
      expect(arr_n_mix.my_all?(8)).to eql(false)
    end
    it "Return false if at least one item don't have the 'b' letter" do
      expect(arr_string.my_all?(/b/)).to eql(false)
    end
    it 'Return true if the length items of all items is greater or equal than 3' do
      expect(arr_string.my_all? { |word| word.length >= 3 }).to eql(true)
    end
  end
  describe '#my_any?' do
    it 'Return true if at least one boolean is true' do
      expect(arr_bool.my_any?).to eql(true)
    end
    it 'Return true if at least one item is a string' do
      expect(arr_mix.my_any?(String)).to eql(true)
    end
    it 'Return true if at least one item is eight' do
      expect(arr_eight.my_any?(8)).to eql(true)
    end
    it "Return true if at least one item have the 'b' letter" do
      expect(arr_string.my_any?(/b/)).to eql(true)
    end
    it 'Return true if at least one length item is greater or equal than 3' do
      expect(arr_string.my_any? { |word| word.length >= 3 }).to eql(true)
    end
  end
  describe '#my_none?' do
    it 'Return false if there is one true boolean' do
      expect(arr_bool.my_none?).to eql(false)
    end
    it 'Return false if there is one string item' do
      expect(arr_string.my_none?(String)).to eql(false)
    end
    it 'Return false if there is one integer item' do
      expect(arr_mix.my_none?(Integer)).to eql(false)
    end
    it 'Return true if there is not a nine integer' do
      expect(arr_n_mix.my_none?(9)).to eql(true)
    end
    it "Return true if there is not an item with an 'u' letter" do
      expect(arr_string.my_none?(/u/)).to eql(true)
    end
    it 'Return false if there is one item with a length greater than 3' do
      expect(arr_string.my_none? { |word| word.length > 3 }).to eql(false)
    end
  end
  describe '#my_count' do
    let(:arr_num) { [1, 2, 4, 2, 5, 7, 9, 3, 5, 6, 1] }
    it 'Return the number of elements' do
      expect(arr_num.my_count).to eql(11)
    end
    it 'Returns how many 2 are there' do
      expect(arr_num.my_count(2)).to eql(2)
    end
    it 'Returns how many numbers are divisible for 3' do
      expect(arr_num.my_count { |x| (x % 3).zero? }).to eql(3)
    end
  end
  describe '#my_map' do
    it 'Return the array of numbers multiply by himself' do
      expect([1, 2, 3, 4].my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end
    it 'Return an array with four items' do
      expect([1, 2, 3, 4].my_map { 'cat' }).to eql(%w[cat cat cat cat])
    end
  end
  describe '#my_inject' do
    let(:num_range) { (5..10) }
    it 'Return the addition of numbers using a symbol' do
      expect(num_range.my_inject(:+)).to eql(45)
    end
    it 'Return the addition of numbers using a block' do
      expect(num_range.my_inject { |sum, n| sum + n }).to eql(45)
    end
    it 'Return the multiplication of numbers using two arguments' do
      expect(num_range.my_inject(1, :*)).to eql(151_200)
    end
    it 'Return the multiplication of numbers using an argument and a block' do
      expect(num_range.my_inject(1) { |product, n| product * n }).to eql(151_200)
    end
    it 'Return the longest string' do
      expect(%w[cat sheep bear].my_inject { |memo, w| memo.length > w.length ? memo : w }).to eql('sheep')
    end
  end
end
# rubocop:enable Layout/LineLength
