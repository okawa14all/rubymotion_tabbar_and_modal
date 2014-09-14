class AppDelegate
  attr_reader :window

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # tab 1
    timeline_controller = MainController.alloc.initWithNibName(nil, bundle: nil)
    tab1_controller = UINavigationController.alloc.initWithRootViewController(timeline_controller)

    # tab 2 (center button perform as 'button', not as controller)
    @post_menu_controller = PostMenuController.new

    # tab 3
    members_controller = MembersController.alloc.initWithNibName(nil, bundle: nil)
    tab2_controller = UINavigationController.alloc.initWithRootViewController(members_controller)

    @tab_controller = UITabBarController.new
    @tab_controller.viewControllers = [tab1_controller, @post_menu_controller, tab2_controller]
    @window.rootViewController = @tab_controller

    @tab_controller.delegate = self
    init_navbar
    init_tabbar

    puts '##### screen height'
    puts UIScreen.mainScreen.bounds.size.height
    puts rmq.device.height
    puts '##### tab height'
    puts @tab_controller.tabBar.frame.size.height

    @window.makeKeyAndVisible
    true
  end

  def init_navbar
    # common appearance
    UINavigationBar.appearance.barTintColor = rmq.color.from_hex('#FF6549')
    UINavigationBar.appearance.tintColor = rmq.color.white
    UINavigationBar.appearance.titleTextAttributes = {
      NSFontAttributeName => UIFont.fontWithName("HelveticaNeue-Light", size:20),
      NSForegroundColorAttributeName => rmq.color.white
    }
  end

  def init_tabbar
    # common appearance
    selectedColor = rmq.color.from_hex('#FF6549')
    UITabBarItem.appearance.setTitleTextAttributes({
        NSFontAttributeName => UIFont.fontWithName("HelveticaNeue-Light", size:10),
      NSForegroundColorAttributeName => selectedColor },
      forState: UIControlStateSelected)
    UITabBar.appearance.setSelectedImageTintColor(selectedColor)

    # center button
    icon = FAKIonIcons.ios7PlusIconWithSize 45
    icon.addAttribute(NSForegroundColorAttributeName, value: selectedColor)
    iconImage = icon.imageWithSize(CGSizeMake(45, 45))
    iconImage = iconImage.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal)
    @post_menu_controller.tabBarItem.image = iconImage
    @post_menu_controller.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
  end

  # UITabBarControllerDelegate Methods
  def tabBarController(tabBarController, shouldSelectViewController:viewController)
    if viewController == @post_menu_controller
      @post_menu_controller.togglePostMenuOnParentVC(@tab_controller)
      false
    else
      true
    end
  end

end
