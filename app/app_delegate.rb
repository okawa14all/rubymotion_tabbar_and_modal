class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    timeline_controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    tab1_controller = UINavigationController.alloc.initWithRootViewController(timeline_controller)

    members_controller = MembersController.alloc.initWithNibName(nil, bundle: nil)
    tab2_controller = UINavigationController.alloc.initWithRootViewController(members_controller)

    tab_controller = UITabBarController.new
    tab_controller.viewControllers = [tab1_controller, tab2_controller]
    @window.rootViewController = tab_controller

    @window.makeKeyAndVisible
    true
  end
end
