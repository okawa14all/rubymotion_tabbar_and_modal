class MembersController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = MembersControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    rmq.append(UILabel, :no_member)
  end

  def init_nav
    self.title = 'Members'

    rightIcon = FAKIonIcons.ios7PlusEmptyIconWithSize 25
    rightIcon.addAttribute(NSForegroundColorAttributeName, value:UIColor.whiteColor)
    rightIconImage = rightIcon.imageWithSize(CGSizeMake(25, 25))
    self.navigationItem.tap do |nav|
      nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithImage(
        rightIconImage.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
        style: UIBarButtonItemStylePlain,
        target: self,
        action: :nav_right_button
      )
    end

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
    icon = FAKIonIcons.ios7PeopleOutlineIconWithSize 30
    self.tabBarItem.image = icon.imageWithSize(CGSizeMake(30, 30))
    self.tabBarItem.title = 'Members'
    self
  end

  def nav_right_button
    controller = AddMemberController.new
    add_member_controller = UINavigationController.alloc.initWithRootViewController(controller)
    self.presentViewController(add_member_controller, animated:true, completion:nil)
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
