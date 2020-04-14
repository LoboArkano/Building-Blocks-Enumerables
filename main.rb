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
end
