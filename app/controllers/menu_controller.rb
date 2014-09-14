class MenuController < UITableViewController
  attr_accessor :tabBarController, :blurImage, :baseDelay

  MENU_CELL_ID = "MenuCell"
  MAX_VISIBLE_VIEWS = 6

  def viewDidLoad
    super

    load_data

    rmq.stylesheet = MenuControllerStylesheet
    # init_nav

    @tableView = self.view
    self.view = rmq.create(UIView, :frame_view).get
    self.view.backgroundColor = UIColor.colorWithPatternImage(blurImage)

    self.view.addSubview(@tableView)

    @tableView.tap do |table|
      table.delegate = self
      table.dataSource = self
      table.setSeparatorInset(UIEdgeInsetsZero)
      rmq(table).apply_style :table
    end

    self.view.addSubview(build_close_button)

    rmq.wrap(@tableView).animations.fade_in
  end

  def viewWillAppear(animated)
    xAnim = POPSpringAnimation.animationWithPropertyNamed(KPOPLayerPositionX)
    xAnim.fromValue = 320
    xAnim.springBounciness = 15
    xAnim.springSpeed = 5
    xAnim.velocity = 20
    @tableView.layer.pop_addAnimation(xAnim, forKey: 'myKey')
  end

  def viewWillDisappear(animated)
    puts '------ MenuController#viewWillDisappear'
  end

  def build_close_button
    leftIcon = FAKIonIcons.ios7CloseEmptyIconWithSize(rmq.stylesheet.menu_close_button_size)
    leftIcon.addAttribute(NSForegroundColorAttributeName, value: rmq.stylesheet.menu_close_button_color)

    button = rmq.create(UIButton, :close_button).on(:touch) do |sender|
      dismissViewWithBaseDelay
    end.get

    button.setAttributedTitle(leftIcon.attributedString, forState:UIControlStateNormal)
    button
  end

  def dismissViewWithBaseDelay(baseDelay = 0)
    puts '----- MenuController.dismissView'
    self.baseDelay = baseDelay
    self.dismissViewControllerAnimated(true, completion:nil)
  end

  def load_data
    @data = (1..10).map do |i|
      {
        name: "menu_#{i}",
        num: i,
      }
    end
  end

  #----------------------------------------------------------
  #  UITableView's delegates
  #----------------------------------------------------------
  def tableView(table_view, numberOfRowsInSection: section)
    @data.length
  end

  def tableView(table_view, heightForRowAtIndexPath: index_path)
    rmq.stylesheet.menu_cell_height
  end

  def tableView(table_view, cellForRowAtIndexPath: index_path)
    data_row = @data[index_path.row]

    cell = table_view.dequeueReusableCellWithIdentifier(MENU_CELL_ID) || begin
      rmq.create(MenuCell, :menu_cell, reuse_identifier: MENU_CELL_ID).get
    end

    cell.update(data_row)
    cell
  end

  def tableView(table_view, didSelectRowAtIndexPath: index_path)
    cell = table_view.cellForRowAtIndexPath(index_path)
    puts "selected #{cell.textLabel.text}"
    rmq(cell.contentView).animate(
      duration: 0.3,
      animations: -> (q) {
        q.animations.throb
      },
      completion: -> (did_finish, q) {
        puts 'amin completion'
        tabBarController.selectedIndex = 0
        dismissViewWithBaseDelay(0.3)
      }
    )
  end

  # apply animation to cell
  def tableView(tableView, willDisplayCell: cell, forRowAtIndexPath: index_path)
    puts "display row:#{index_path.row}, section:#{index_path.section}"
  end

end
