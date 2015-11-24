#!/Users/jhbrooks/.rvm/rubies/ruby-2.2.0/bin/ruby

class Node
  def self.build_tree(array)
    tree = Node.new(nil, nil, nil, nil)
    array.each do |elem|
      tree.place_new_value(elem)
    end
    tree
  end

  attr_accessor :parent, :value, :l_child, :r_child

  def initialize(parent, value, l_child, r_child)
    @parent = parent
    @value = value
    @l_child = l_child
    @r_child = r_child
  end

  def place_new_value(new_value)
    if value.nil?
      self.value = new_value
    elsif new_value < value
      self.l_child = Node.new(self, nil, nil, nil) if l_child.nil?
      l_child.place_new_value(new_value)
    else
      self.r_child = Node.new(self, nil, nil, nil) if r_child.nil?
      r_child.place_new_value(new_value)
    end
  end

  def breadth_first_search(t_value, searched_nodes = [], search_queue = [self])
    searched_nodes.push(self)

    if value == t_value
      self
    else
      search_queue.shift

      search_queue.push(l_child) unless searched_nodes.include?(l_child) || l_child.nil?
      search_queue.push(r_child) unless searched_nodes.include?(r_child) || r_child.nil?

      if !search_queue.empty?
        next_node = search_queue.first
        next_node.breadth_first_search(t_value, searched_nodes, search_queue)
      else
        nil
      end
    end
  end

  def to_s
    # provisional
    # should be easier to improve after defining search methods
    "V: #{value} L[ #{l_child} ] R[ #{r_child} ]"
  end
end

tree = Node.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p tree.breadth_first_search(6345).object_id
p tree.breadth_first_search(77)

