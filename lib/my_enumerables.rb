module IndexLoopHelper
  def each_index_yielding
    for i in 0...self.size
      yield(self[i])
    end
  end
end

module Enumerable
  def my_each_with_index
    
  end
end

class Array
  include IndexLoopHelper

  def my_each
    each_index_yielding { |i| yield(i) }
    self
  end
end
