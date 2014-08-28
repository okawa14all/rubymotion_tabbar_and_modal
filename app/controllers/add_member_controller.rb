class AddMemberController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = AddMemberControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    # Create your views here
  end

  def init_nav
    self.title = 'Add Member'
    self.navigationItem.tap do |nav|
      nav.rightBarButtonItem = UIBarButtonItem.alloc.initWithTitle(
        '完了',
        style: UIBarButtonItemStylePlain,
        target: self,
        action: :dismissView
      )
    end
  end

  def dismissView
    self.dismissViewControllerAnimated(true, completion:nil)
  end
end
