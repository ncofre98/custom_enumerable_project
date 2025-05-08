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
end

class Array
  include IndexLoopHelper

  def my_each
    each_index_yielding { |i| yield(self[i]) }
    self
  end
end

#[42, 69, 1024].each_with_index { |e, i| puts "Position: #{i}, Value: #{e}" }
# expected: Position: 0, Value: 42 ... etc
