class Tower
  attr_accessor :name, :weight, :child_names
  
  @@towers = nil
  
  def initialize(name, weight, children)
    @name = name
    @weight = weight
    @child_names = children || []
    # puts "New Tower: #{inspect}"
  end

  def self.parse(string)
    me, kids = string.split(' -> ')
    name, weight = me.scan(/(\w+) \((\d+)\)/)[0]
    kids = kids&.split(", ")
    new(name, weight.to_i, kids)
  end
  
  def self.find(name)
    @@towers.find{ |t| t.name == name }
  end

  def children
    child_names.map{ |name| Tower.find(name) }
  end
  
  def stack_weight
    weight + children.sum{ |child| child.weight }
  end
  
  def balanced?
    return true if children.count < 2
    child_stack_weights.uniq.length == 1
  end
  
  def unbalanced?
    child_stack_weights.uniq.count == 2
  end
    
  def parent
    @@towers.find{ |t| t.child_names&.include?(name) }
  end
  
  def child_stack_weights
    children.map{ |child| child.stack_weight}
  end
  
  def self.read_input
    @@towers = IO.read('input.txt').split("\n").map{ |l| parse(l) }
  end
  
  def self.part_one
    read_input
    root.name
  end
  
  def self.part_two
    read_input
    # @@towers.reject{|t| t.balanced? }.each{ |t| puts t.child_stack_weights.inspect }
    @@towers.find{ |t| t.unbalanced? } #.children.map{|t| [t.name,t.stack_weight,t.weight, t.weight + t.stack_weight].inspect}
  end
    
  # def self.run
  #   @@towers = IO.read('input.txt').split("\n").map{ |l| parse(l) }
  #   puts @@towers.select{|t| t.unbalanced? }.inspect
    # @@towers.reject{|t| t.balanced? }.each{|t| puts ([t.name] + [t.parent&.name||'------'] + t.child_stack_weights).inspect }
    # puts @@towers.map{|x| x.child_stack_weights.uniq.count}.sort
    # putsunbalanced = @@towers.reject{|t| t.balanced?}.reject{|t| t.parent}[0]
  # end
  
  def self.root
    read_input
    @@towers.find{ |t| t.parent.nil? }
  end
  
  def graph
    child_names.each do |c| 
      puts "\"#{name}\" -> \"#{c}\""
    end
    children.each(&:graph)
    @@towers.each do |t|
      puts "\"#{t.name}\" [label = \"#{t.name}\\n#{t.stack_weight}\"]"
    end
    nil
  end
    
  
  puts Tower.part_one
  puts Tower.part_two
end


