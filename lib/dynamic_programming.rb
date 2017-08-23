require 'byebug'
class DynamicProgramming
  attr_accessor :blair_cache, :frog_cache
   def initialize
   @blair_cache = { 1 => 1, 2 => 2 }
   @frog_cache = { 1 => 1, 2 => 2, 3 => 4 }
   @frog_numbers = [1, 2, 3]
 end

 def blair_nums(n)
   # Base case(s): which inputs n should return early?
   # Recursive case: what's the recursive relationship?
   # *NB*: you'll need to figure out how to express the nth odd number in terms of n.
   return @blair_cache[n] if n < 3
   return @blair_cache[n] if @blair_cache[n]
   n_minus_one_odd = 1 + 2 * (n - 2)
   ans = blair_nums(n - 1) + blair_nums(n - 2) + n_minus_one_odd
   @blair_cache[n] = ans
   ans
 end

 def frog_hops_bottom_up(n)
   frog_hash = frog_cache_builder(n)
   frog_hash[n].uniq
 end

 def frog_cache_builder(num)
   frog_cache = { 1 => [[1]], 2 => [[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
   (4..num).each do |idx|
     results = []
     combined_arr = frog_cache[idx - 1] + frog_cache[idx - 2] + frog_cache[idx - 3]
     combined_arr.each do |el1|
       combined_arr.each do |el2|
         results << el1 + el2 if el1.reduce(:+) + el2.reduce(:+) == idx
         puts "ding!" if el1.reduce(:+) + el2.reduce(:+) == idx
       end
     end
     debugger
    frog_cache[idx] = results
  end
  frog_cache
 end

 def frog_hops_top_down(n)
   return @frog_cache[n] if n < 4
   return @frog_cache[n] if @frog_cache[n]
   frog_hops_top_down_helper(n)

 end

def frog_hops_top_down_helper(n)
  ans = @frog_cache[n - 1] + @frog_cache[n - 2] + @frog_cache[n - 3]
  @frog_cache[n] = ans
  ans
end

def super_frog_hops(n, k)

end

def knapsack(weights, values, capacity)
  items_count = weights.length
  table = Array.new(items_count){Array.new(capacity + 1, 0)}

  items_count.times do |i|
    (capacity + 1).times do |j|
      if weights[i] > j
        table[i][j] = table[i - 1][j]
      else
        table[i][j] = [table[i - 1][j], values[i] + table[i - 1][j - weights[i]]].max
      end
    end
  end
  stored_items = finder(weights, values, table)


end

def finder(weights, values, table)
  i = table.length - 1
  cost = table[0].length - 1
  marked = table.map{0}

  while i >= 0 && cost >= 0
    if i ==0 && table[i][cost] > 0 || table[i][cost] != table[i - 1][cost]
      marked[i] = 1
      cost -= weights[i]
    end
    i -= 1
  end
  marked
end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
