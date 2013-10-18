class SimulationController < UIViewController
  attr_accessor :critters, :max_wide, :max_height, :game_timer

  CRITTER_SIZE = 20
  INITIAL_POPULATION = 3

  def initWithNibName(name, bundle: bundle)
    super

    self.tabBarItem = UITabBarItem.alloc.initWithTitle(
      "Life",
      image: nil,
      tag: 1)

    @critters = []
    @game_timer = nil

    self
  end

  def viewDidLoad
    super

    @max_wide = self.view.frame.size.width / CRITTER_SIZE
    @max_height = self.view.frame.size.height / CRITTER_SIZE

    self.view.backgroundColor = UIColor.whiteColor

    initial_population
  end

  def live_loop
    game_timer = EM.add_periodic_timer 0.25 do
      @critters.each do |critter|
        critter.tick(@critters)
      end
    end
  end

  def initial_population
    @count = 0
    timer = EM.add_periodic_timer 0.10 do
      @count += 1
      critter = create_critter
      self.view.addSubview(critter.view)
      @critters << critter
      EM.cancel_timer(timer) if @count > INITIAL_POPULATION
    end

    live_loop
  end

  def random_x
    rand(@max_wide) - 1
  end

  def random_y
    rand(@max_height) - 1
  end

  def create_critter
    x = random_x
    while critters.any?{|c| c.x == x} do
      x = random_x
    end

    y = random_y
    while critters.any?{|c| c.y == y} do
      y = random_y
    end

    view = UIView.alloc.initWithFrame(
      CGRect.new([x * CRITTER_SIZE, y * CRITTER_SIZE], [CRITTER_SIZE,CRITTER_SIZE]))
    view.backgroundColor = UIColor.redColor
    Critter.new(x,y,view)
  end


end
