class Node
     attr_accessor :value, :next_node

    def initialize(value = nil, next_node = nil)
        @value = value
        @next_node = next_node
    end
end

class LinkedList
    attr_accessor :head, :tail, :size 

    def initialize
        @head = nil
        @tail = nil 
        @size = 0
    end

    def append(value) 
        node = Node.new(value)
        @head.nil? ? @head = node : @tail.next_node = node 
        @tail = node 
        @size += 1
    end

    def prepend(value)
        node = Node.new(value)
        @tail = node if @head.nil?
        node.next_node = @head 
        @head = node 
        @size += 1
    end

    def at(index)
        return 'Invalid index' if !index.is_a?(Integer) || index < 0 || index > @size - 1 
        temp = @head 
        index.times do
            temp = temp.next_node
        end
        temp
    end

    def pop 
        return 'List is empty' if @size.zero?
        temp = @tail
        size > 1 ? @tail = at(size - 2) : @head = nil && @tail = nil
        @tail.next_node = nil
        @size -= 1
        temp
    end

    def contains?(value , node = @head)
        return false if  node == nil

        return true if node.value == value
        contains?(value, node.next_node)
    end

    def find(value , node = @head , index = 0)
        return 'nil' if node == nil 

        return index if node.value == value 
        find(value, node.next_node, index + 1)
    end

    def to_s 
        str = ''
        temp = @head
        while true
            break if temp.nil?
            str += "( #{temp.value} ) -> "
            temp = temp.next_node
        end
        str += 'nil'
    end

    def insert_at(value, index) 
        return 'Invalid index' if !index.is_a?(Integer) || index < 0 || index > @size

        return prepend(value) if index.zero?
        return append(value) if index == size

        node = Node.new(value, at(index))
        at(index - 1).next_node = node 
        @size += 1
    end

    def remove_at(index) 
        return 'Invalid index' if !index.is_a?(Integer) || index < 0 || index > @size - 1 

        return pop if index == @size - 1

        if index.zero?
            if @size == 1
                @head = nil 
                @tail = nil 
                @size = 0 
            else
                @head = @head.next_node 
                @size -= 1 
            end
        else
            at(index - 1).next_node = at(index).next_node 
            @size -= 1
        end
    end
end




name = LinkedList.new

puts '', name.to_s, ''

name.append('Aks')
name.append('hat')
name.prepend('007')
name.append('Ce')
name.prepend('Les')
name.append('Tial')

puts name.to_s
puts name.size
puts name.head , name.head.value
puts name.tail, name.tail.value , ''

puts name.at('2'), name.at(2), name.at(-2)
puts name.at(2).value, ''

hola = LinkedList.new 
puts hola.pop
hola.append('123')
puts hola.pop
puts hola.to_s , ''

puts name.contains?('ajs')
puts name.contains?('hat')
puts name.find('aja')
puts name.find('hat'), ''

name.insert_at('123', 0)
puts name.to_s
name.remove_at(0)
puts name.to_s
name.insert_at('123', 4)
puts name.to_s
name.remove_at(name.find('123'))
puts name.to_s