module Enumerable
  def my_each
    index = 0

    while index < size
      yield self[index]
      index += 1
    end
  end

  def my_each_with_index
    item = 0
    index = 0

    while index < size
      yield self[item], index
      index += 1
      item += 1
    end
  end

  def my_select
    arr = []

    my_each do |item|
      arr.push(item) if yield item
    end
    arr
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
end
