class MainController < UIViewController

  def viewDidLoad
    super

    # Sets a top of 0 to be below the navigation control, it's best not to do this
    # self.edgesForExtendedLayout = UIRectEdgeNone

    rmq.stylesheet = MainStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    # Create your UIViews here
    @hello_world_label = rmq.append(UILabel, :hello_world).get

    imageView = rmq.append(UIImageView, :image).get
    imageView.image = UIImage.imageNamed('test.jpg')
  end

  def init_nav
    self.title = 'Timeline'

    leftIcon = FAKIonIcons.ios7HomeOutlineIconWithSize 25
    leftIcon.addAttribute(NSForegroundColorAttributeName, value:UIColor.whiteColor)
    leftIconImage = leftIcon.imageWithSize(CGSizeMake(25, 25))
    self.navigationItem.tap do |nav|
      nav.leftBarButtonItem = UIBarButtonItem.alloc.initWithImage(
        leftIconImage.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
        style: UIBarButtonItemStylePlain,
        target: self,
        action: :nav_left_button
      )
    end
  end

  def initWithNibName(name, bundle: bundle)
    super
    icon = FAKIonIcons.ios7ClockOutlineIconWithSize 30
    self.tabBarItem.image = icon.imageWithSize(CGSizeMake(30, 30))
    self.tabBarItem.title = 'Timeline'
    self
  end

  def nav_left_button
    blurImage = blurImageFromCurrentScreen
    menu_controller = MenuController.new
    menu_controller.tabBarController = self.tabBarController
    menu_controller.transitioningDelegate = self # UIViewControllerTransitioningDelegate
    menu_controller.modalPresentationStyle = UIModalPresentationCustom
    menu_controller.blurImage = blurImage
    self.presentViewController(menu_controller, animated:false, completion:nil)
  end

  def blurImageFromCurrentScreen
    rmq.wrap(rmq.app.window).tap do |o|
      o.append(UIView, :overlay)
    end

    UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0)
    rmq.window.layer.renderInContext(UIGraphicsGetCurrentContext())
    img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    blurImage = img.blurredImageWithRadius(10, iterations: 2, tintColor: nil)

    rmq.wrap(rmq.app.window).find(:overlay).hide.remove

    blurImage
  end

  #----------------------------------------------------------
  #  UIViewControllerTransitioningDelegate
  #----------------------------------------------------------
  def animationControllerForDismissedController(dismissed_vc)
    MenuDismissAnimationController.new
  end

end
