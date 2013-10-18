class SettingsController < UIViewController
  def initWithNibName(name, bundle: bundle)
    super

    self.tabBarItem = UITabBarItem.alloc.initWithTitle(
      "Settings",
      image: nil,
      tag: 1)

    self
  end

  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.whiteColor

    @label = UILabel.alloc.initWithFrame(CGRectZero)
    @label.text = "Mobile Life"
    @label.sizeToFit
    @label.center = [self.view.frame.size.width / 2,
                    self.view.frame.size.height / 2]
    @label.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin |
                              UIViewAutoresizingFlexibleTopMargin
    self.view.addSubview(@label)
  end
end