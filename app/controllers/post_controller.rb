class PostController < UIViewController

  def viewDidLoad
    super

    rmq.stylesheet = PostControllerStylesheet
    init_nav
    rmq(self.view).apply_style :root_view

    # Create your views here
  end
  
  def init_nav
    self.title = '投稿'
    self.navigationItem.tap do |nav|
      nav.leftBarButtonItem = UIBarButtonItem.alloc.initWithTitle(
        'キャンセル',
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
