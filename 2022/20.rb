INPUT = File.readlines('20.txt', chomp: true)

class DoubleLinkedList
  include Enumerable

  Node = Struct.new(:key, :val, :next, :prev)

  def initialize()
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def head
    @head.next
  end

  def tail
    @tail.prev
  end

  def delete(entry)
    entry.prev.next = entry.next
    entry.next.prev = entry.prev
  end

  def insert_before(node, entry)
    entry.next = node
    entry.prev = node.prev
    node.prev = entry
    entry.prev.next = entry
  end

  def insert_after(node, entry)
    entry.prev = node
    entry.next = node.next
    node.next = entry
    entry.next.prev = entry
  end

  def prepend(entry)
    insert_after(@tail, entry)
  end

  def append(entry)
    insert_before(@tail, entry)
  end

  def each
    node = head

    until node.next.nil?
      yield node
      node = node.next
    end
  end
end

[
  { decryption_key: 1, rounds: 1 },
  { decryption_key: 811589153, rounds: 10 },
].each do |config|
  numbers = INPUT.map.with_index { DoubleLinkedList::Node.new(_2, _1.to_i * config[:decryption_key]) }

  list = DoubleLinkedList.new
  numbers.each { list.append(_1) }

  config[:rounds].times do
    numbers.each do |number|
      moves = number.val % (numbers.length - 1)

      next if moves == 0

      list.delete(number)

      if moves > 0
        insert_after = number
        moves.times do
          insert_after = insert_after.next
          insert_after = list.head if insert_after.next.nil?
        end
        list.insert_after(insert_after, number)
      else
        insert_before = number
        moves.times do
          insert_before = insert_before.prev
          insert_before = list.tail if insert_before.prev.nil?
        end
        list.insert_before(insert_before, number)
      end
    end
  end

  res = 0
  node = list.detect { _1.val == 0 }
  3.times do
    1000.times do
      node = node.next
      node = list.head if node.next.nil?
    end

    res += node.val
  end
  puts res
end
