class Critter
  attr_accessor :id, :health, :x, :y, :view

  CRITTER_SIZE = 20

  def initialize(x, y, view)
    @health = 10
    @x = x
    @y = y
    @view = view
  end

  def tick(critters, parent)
    neighbor_count = count_nearest_neighbors(critters)
    puts neighbor_count
    if neighbor_count == 0
      self.health = self.health - 2
    elsif neighbor_count >= 2
      self.health = self.health + neighbor_count
    end

    self.health = self.health - 1

    if self.health <= 0
      die(parent)
    elsif self.health > 20
      give_birth(parent, critters)
    end
  end

  def die(parent)
    parent.kill_child(self)
  end

  def give_birth(parent, critters)
    # find an empty place
    coords = find_new_place(critters)
    if coords
      view = UIView.alloc.initWithFrame(
        CGRect.new([coords[:x] * CRITTER_SIZE, coords[:y] * CRITTER_SIZE], [CRITTER_SIZE,CRITTER_SIZE]))
      view.backgroundColor = UIColor.blueColor
      child = Critter.new(coords[:x],coords[:y],view)
      parent.add_child(child)
    else
      puts "No Room for this child!"
    end
  end

  # look for something empty
  def find_new_place(critters)
    x = [-1, 0, 1]
    y = [-1, 1]

    new_x = self.x + x.sample
    new_y = self.y + y.sample
    if critters.any?{|c| c.x == new_x && c.y == new_y}
      nil
    else
      return {x: new_x, y: new_y}
    end
  end

  # Look in all surrounding locations
  def count_nearest_neighbors(critters)
    nc = 0
    nc += critters.count{|c| [@x - 1, @x, @x + 1].include?(c.x) && c.y = @y - 1}
    nc += critters.count{|c| [@x - 1, @x + 1].include?(c.x) && c.y = @y}
    nc += critters.count{|c| [@x - 1, @x, @x + 1].include?(c.x) && c.y = @y + 1}
    nc
  end
end