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
end
