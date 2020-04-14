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
      yield self[index], item
      index += 1
    end
  end
end
