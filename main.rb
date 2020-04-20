# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength
# rubocop:disable Metrics/MethodLength
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    index = 0
    arr = to_a if respond_to?(:to_h)
    arr = self if respond_to?(:to_a)
    while index < size
      yield arr[index]
      index += 1
    end
  end

  def my_each_with_index
    return to_enum(:my_each) unless block_given?

    item = 0
    index = 0

    while index < size
      yield self[item], index
      index += 1
      item += 1
    end
  end

  def my_select
    return to_enum(:my_each) unless block_given?

    selected = []
    arr = self if respond_to?(:to_a)
    arr = *self if is_a?(Range)
    arr = to_a if respond_to?(:to_h)

    arr.my_each do |item|
      selected.push(item) if yield item
    end
    selected
  end

  def my_all?(arg = nil)
    bool = true
    if !block_given?
      if arg.nil?
        bool = false if include?(false) || include?(nil)
      elsif arg.respond_to?(:to_i)
        my_each { |item| bool = false unless item == arg }
      elsif arg.is_a?(Regexp)
        my_each { |item| bool = false unless item.match(arg) }
      elsif arg.respond_to?(:class)
        my_each { |item| bool = false unless item.instance_of? arg }
      end
    else
      my_each { |item| bool = false unless yield item }
    end
    bool
  end

  def my_any?(arg = nil)
    bool = false
    if !block_given?
      if arg.nil?
        bool = true if include?(true)
      elsif arg.respond_to?(:to_i)
        my_each { |item| bool = true if item == arg }
      elsif arg.is_a?(Regexp)
        my_each { |item| bool = true if item.match(arg) }
      elsif arg.respond_to?(:class)
        my_each { |item| bool = true if item.instance_of? arg }
      end
    else
      my_each { |item| bool = true if yield item }
    end
    bool
  end

  def my_none?(arg = nil)
    bool = true
    if !block_given?
      if arg.nil?
        bool = false if include?(true)
      elsif arg.respond_to?(:to_i)
        my_each { |item| bool = false if item == arg }
      elsif arg.is_a?(Regexp)
        my_each { |item| bool = false if item.match(arg) }
      elsif arg.respond_to?(:class)
        my_each { |item| bool = false if item.instance_of? arg }
      end
    else
      my_each { |item| bool = false if yield item }
    end
    bool
  end

  def my_count(arg = nil)
    count = 0

    if !block_given?
      if arg.nil?
        count = length
      else
        my_each { |item| count += 1 if item == arg }
      end
    else
      my_each { |item| count += 1 if yield item }
    end
    count
  end

  def my_map
    return to_enum(:my_each) unless block_given?

    arr = []

    my_each do |item|
      arr.push(yield item)
    end
    arr
  end

  def my_inject(memo = 0, operation = nil)
    arr = self if respond_to?(:to_a)
    arr = to_a if is_a?(Range)

    if memo.is_a?(Symbol)
      operation = memo
      memo = 0
    end

    if operation.is_a?(Symbol)
      case operation
      when :+
        memo = arr.my_inject(memo) { |acum, item| acum + item }
      when :-
        memo = arr.my_inject(memo) { |acum, item| acum - item }
      when :*
        memo = arr.my_inject(memo) { |acum, item| acum * item }
      when :/
        memo = arr.my_inject(memo) { |acum, item| acum / item }
      else
        puts 'Invalid operator'
      end
    else
      if memo.zero?
        memo = arr[0]
        arr.shift
      end
      arr.my_each do |item|
        memo = yield memo, item
      end
    end
    memo
  end
end

def multiply_els(arr)
  result = arr.my_inject { |product, val| product * val }
  result
end
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
# rubocop:enable Metrics/MethodLength
