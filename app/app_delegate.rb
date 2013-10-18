class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    @intro_controller = SettingsController.alloc.initWithNibName(nil, bundle: nil)
    @controller = SimulationController.alloc.initWithNibName(nil, bundle: nil)

    tab_controller = UITabBarController.alloc.initWithNibName(nil, bundle: nil)
    tab_controller.viewControllers = [@intro_controller,@controller]
    @window.rootViewController = tab_controller
    true
  end
end
