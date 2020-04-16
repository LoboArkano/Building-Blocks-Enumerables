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
    arr = *self if respond_to?(:range)
    arr = to_a if respond_to?(:to_h)

    arr.my_each do |item|
      selected.push(item) if yield item
    end
    selected
  end

  def my_all?
    bool = true

    my_each do |item|
      bool = false unless yield item
    end
    bool
  end

  def my_any?
    bool = false

    my_each do |item|
      bool = true if yield item
    end
    bool
  end

  def my_none?
    bool = true

    my_each do |item|
      bool = false if yield item
    end
    bool
  end

  def my_count
    count = 0

    my_each do |item|
      count += 1 if yield item
    end
    count
  end

  def my_map
    arr = []

    my_each do |item|
      arr.push(yield item)
    end
    arr
  end

  def my_inject(memo = 0)
    arr = to_a

    if memo.zero?
      memo = arr[0]
      arr.shift
    end

    my_each do |item|
      memo = yield memo, item
    end
    memo
  end
end

def multiply_els(arr)
  result = arr.my_inject { |product, val| product * val }
  result
end
