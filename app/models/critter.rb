class Critter
  attr_accessor :id, :health, :x, :y, :view

  def initialize(x, y, view)
    @health = 10
    @x = x
    @y = y
    @view = view
  end

  def tick(critters)
    neighbor_count = count_nearest_neighbors(critters)
    puts neighbor_count
    if neighbor_count == 0
      self.health = self.health - 2
    elsif neighbor_count > 2
      self.health = self.health + neighbor_count
    else
      self.health = self.health - 1
    end

    if self.health <= 0
      die
    elsif self.health > 20
      give_birth
    end
  end

  def die
  end

  def give_birth
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