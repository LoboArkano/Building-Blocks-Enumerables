# rubocop:disable Layout/LineLength
require './main.rb'

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
  end

  let(:arr_bool) { [true, true, false] }
  let(:arr_string) { %w[ant bear bat] }
  let(:arr_mix) { ['ant', 'bear', 8] }
  let(:arr_eight) { [8, 8, 8] }
  let(:arr_n_mix) { [8, 7, 6] }
  describe '#all?' do
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
      expect(arr_height.my_all?(8)).to eql(true)
    end
    it "Return false if at least one item don't have the 'b' letter" do
      expect(arr_string.my_all?(/b/)).to eql(false)
    end
    it 'Return true if the length items of all items is greater or equal than 3' do
      expect(arr_string.my_all? { |word| word.length >= 3 }).to eql(true)
    end
  end
end
# rubocop:enable Layout/LineLength
