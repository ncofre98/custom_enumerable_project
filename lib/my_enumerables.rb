module IndexLoopHelper
  def each_index_yielding
    for i in 0...self.size
      yield(i)
    end
  end
end

module Enumerable
  def my_each_with_index
    each_index_yielding { |i| yield(self[i], i) }
    self
  end

  def my_select
    filtered = []
    each_index_yielding { |i| filtered << self[i] if yield(self[i]) }
    filtered
  end

  def my_all?
    each_index_yielding { |i| return false if !yield(self[i]) }
    true
  end

  def my_any?
    each_index_yielding { |i| return true if yield(self[i]) }
    false
  end

  def my_none?
    self.size == 0 || !block_given? || !(my_any? { |i| yield(i) } )
  end

  def my_count
    return self.size if self.size == 0 || !block_given?
    counter = 0
    each_index_yielding { |i| counter += 1 if yield(self[i]) }
    counter
  end

  def my_map
    return to_enum(:my_map) unless block_given?
    arr = [nil] * self.size
    each_index_yielding do |i|
      arr[i] = yield(self[i])
    end
    arr
  end

  def my_inject(sum = 0)
    return nil unless block_given?
    each_index_yielding do |i|
      sum = yield(sum, self[i])
    end
    sum
  end
end

class Array
  include IndexLoopHelper

  def my_each
    each_index_yielding { |i| yield(self[i]) }
    self
  end
end
