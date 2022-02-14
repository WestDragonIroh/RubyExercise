require_relative 'node'

class Tree 
    attr_accessor :root 

    def initialize (array)
        @root = build_tree(array)
    end

    def build_tree(array)
        return if array.empty?

        array = array.sort.uniq
        build_sort(array)
    end
    def build_sort(array) 
        return if array.empty?

        middle = array.length / 2
        node = Node.new(array[middle])
        node.left = build_sort(array[0...middle])
        node.right = build_sort(array[(middle + 1)..-1])
        node
    end

    def insert(value, node = @root)
        return if value == node.data

        if value < node.data
            node.left ? insert(value, node.left) : node.left = Node.new(value)
        else
            node.right ? insert(value, node.right) : node.right = Node.new(value)
        end
    end

    def delete(value, node = @root)
        return node if node.nil?

        if value < node.data 
            node.left = delete(value , node.left)
        elsif value > node.data 
            node.right = delete(value, node.right)
        else
            return node.left if node.right.nil?
            return node.right if node.left.nil?

            left_node = left_most(node.right)
            puts '', left_node.data, ''
            node.data = left_node.data
            node.right = delete(left_node.data, node.right)
        end
        node
    end
    def left_most(node)
        node = node.left until node.left.nil?
        node
    end

    def find (value , node = @root)
        return nil if node.nil?
        
        if value < node.data
            node = find(value, node.left) 
        elsif value > node.data
            node = find(value, node.right)
        end
        node
    end

    def level_order(node = @root)
        array, queue = [], [node]
        
        while not queue.empty?
            node = queue.shift
            array << node.data
            queue << node.left if node.left
            queue << node.right if node.right
        end
        array
    end

    def inorder(node = @root, array = [])
        return array if not node

        array = inorder(node.left, array)
        array << node.data
        array = inorder(node.right, array)
        array
    end

    def preorder(node = @root, array = [])
        return array if not node

        array << node.data
        array = preorder(node.left, array)
        array = preorder(node.right, array)
        array
    end

    def postorder(node = @root, array = [])
        return array if not node

        array = postorder(node.left, array)
        array = postorder(node.right, array)
        array << node.data
        array
    end

    def height(node = @root)
        return 0 if node.nil?
        height = 1 + [height(node.left), height(node.right)].max
        height
    end

    def depth(node = @root)
        height(@root) - height(node)
    end

    def balanced?(node = @root)
        return true if node.nil?

        balanced?(node.left) and balanced?(node.right) and (height(node.left) - height(node.right)).abs < 2 ? true : false  
    end

    def rebalance
        @root = build_tree(inorder)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end
