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
    icon = FAKIonIcons.ios7PlusEmptyIconWithSize 20
    iconImage = icon.imageWithSize(CGSizeMake(20, 20))
    self.navigationItem.tap do |nav|
      nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithImage(
        iconImage.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal),
        style: UIBarButtonItemStylePlain,
        target: self,
        action: :nav_right_button
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
end
