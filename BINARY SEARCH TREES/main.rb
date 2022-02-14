require_relative 'tree.rb'

a = Array.new(15) { rand(1..100) }
b = Tree.new(a)

p b.balanced?
b.pretty_print

p b.level_order, b.inorder, b.preorder, b.postorder

8.times { b.insert(rand(101..200)) }
b.pretty_print

p b.balanced?
b.rebalance
b.pretty_print
p b.balanced?

p b.level_order, b.inorder, b.preorder, b.postorder