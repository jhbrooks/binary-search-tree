#!/Users/jhbrooks/.rvm/rubies/ruby-2.2.0/bin/ruby

# This class builds and searches binary search trees
class Node
  def self.build_tree(array)
    tree = Node.new(nil, nil, nil, nil)
    array.each do |elem|
      tree.place_new_value(elem)
    end
    tree
  end

  attr_accessor :parent, :value, :l_child, :r_child, :line_width

  def initialize(parent, value, l_child, r_child)
    @parent = parent
    @value = value
    @l_child = l_child
    @r_child = r_child
    @line_width = 80
  end

  def place_new_value(new_value)
    if value.nil?
      self.value = new_value
    elsif new_value < value
      self.l_child ||= Node.new(self, nil, nil, nil)
      l_child.place_new_value(new_value)
    else
      self.r_child ||= Node.new(self, nil, nil, nil)
      r_child.place_new_value(new_value)
    end
  end

  def breadth_first_search(targ, searched = [], queue = [self])
    # not needed, but would be if heirarchy were more complex
    searched.push(self)

    return self if value == targ

    queue.shift
    queue.push(l_child) unless searched.include?(l_child) || l_child.nil?
    queue.push(r_child) unless searched.include?(r_child) || r_child.nil?

    return nil if queue.empty?

    next_node = queue.first
    next_node.breadth_first_search(targ, searched, queue)
  end

  def depth_first_search(targ, searched = [], stack = [self])
    # not needed, but would be if heirarchy were more complex
    searched.push(self)

    return self if value == targ

    stack.pop
    stack.push(r_child) unless searched.include?(r_child) || r_child.nil?
    stack.push(l_child) unless searched.include?(l_child) || l_child.nil?

    return nil if stack.empty?

    next_node = stack.last
    next_node.depth_first_search(targ, searched, stack)
  end

  def dfs_rec(targ)
    # no search tracking, so could fail if heirarchy were more complex
    if value == targ
      self
    else
      (l_child && l_child.dfs_rec(targ)) || (r_child && r_child.dfs_rec(targ))
    end
  end

  def to_s
    return_array = ["P: #{parent && parent.value}",
                    "|",
                    "V: #{value}",
                    "/ \\",
                    "L: #{l_child && l_child.value} "\
                    "R: #{r_child && r_child.value}"]
    return_array.map { |e| e.center(line_width) }.join("\n")
  end
end

tree = Node.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts "Root node of tree:\n#{tree}"
puts "BFS for value in tree (9):\n#{tree.breadth_first_search(9)}"
puts "BFS for value not in tree (6):\n#{tree.breadth_first_search(6)}"
puts "DFS for value in tree (9):\n#{tree.depth_first_search(9)}"
puts "DFS for value not in tree (6):\n#{tree.depth_first_search(6)}"
puts "Recursive DFS for value in tree (9):\n#{tree.dfs_rec(9)}"
puts "Recursive DFS for value not in tree (6):\n#{tree.dfs_rec(6)}"
