class PostMenuController < UIViewController

  def init
    super
    @showed = false
    # rmq.stylesheet = PostMenuControllerStylesheet
    self
  end

  def togglePostMenuOnParentVC(parentVC)
    rmq.stylesheet = PostMenuControllerStylesheet
    @parentVC = parentVC
    if @showed
      hideMenu
    else
      showMenu
    end
  end

  def viewDidLoad
    super
    puts 'PostMenuController#viewDidLoad'
  end

  def showMenu
    rmq.wrap(rmq.app.window).tap do |window|
      # overlay on screen
      window.append(UIView, :overlay_menu).on(:tap) do |sender|
        hideMenu
      end

      # center close button
      center_button = buildCenterButtonOn(window)
      center_button.layer.zPosition = 1
      rotateAnim = rotate_animation(- Math::PI * 0.75, 10)
      center_button.layer.pop_addAnimation(rotateAnim, forKey: 'rotate')

      # post menu buttons
      [:photo, :movie, :text, :location, :music, :greeting].each_with_index do |type, i|
        menu_button = buildMenuButtonOn(window, type)
        anim_x = menu_item_animation_x(:show, type, 0.05*i)
        anim_y = menu_item_animation_y(:show, type, 0.05*i)
        anim_rotate = rotate_animation(Math::PI * 10, 10)
        menu_button.layer.pop_addAnimation(anim_x, forKey: "show_#{type}_x")
        menu_button.layer.pop_addAnimation(anim_y, forKey: "show_#{type}_y")
        menu_button.layer.pop_addAnimation(anim_rotate, forKey: "show_#{type}_rotate")
      end
    end

    @showed = true
  end

  def hideMenu
    center_button = rmq.wrap(rmq.app.window).find(:center_button).get
    rotateAnim = rotate_animation(0, 0)
    rotateAnim.completionBlock = -> (anim, finished) {
      rmq(center_button).remove
    }
    center_button.layer.pop_addAnimation(rotateAnim, forKey: 'rotate_center_button')

    [:photo, :movie, :text, :location, :music, :greeting].each_with_index do |type, i|
      menu_button = rmq.wrap(rmq.app.window).find(type).get
      anim_x = menu_item_animation_x(:hide, type, 0.02*i)
      anim_x.completionBlock = -> (anim, finished) {
        rmq(menu_button).remove
      }
      anim_y = menu_item_animation_y(:hide, type, 0.02*i)
      anim_rotate = rotate_animation(- Math::PI * 3, 0)
      anim_fade = fadeout_animation_with_delay(0.2)
      menu_button.layer.pop_addAnimation(anim_x, forKey: "hide_#{type}_x")
      menu_button.layer.pop_addAnimation(anim_y, forKey: "hide_#{type}_y")
      menu_button.layer.pop_addAnimation(anim_rotate, forKey: "hide_#{type}_rotate")
      menu_button.layer.pop_addAnimation(anim_fade, forKey: "hide_#{type}_fade")
    end

    overlay = rmq.wrap(rmq.app.window).find(:overlay_menu).get
    fadeAnim = fadeout_animation_with_delay(0.1)
    fadeAnim.completionBlock = -> (anim, finished) {
      rmq(overlay).remove
    }
    overlay.layer.pop_addAnimation(fadeAnim, forKey: "fade_overlay")

    @showed = false
  end

  def buildCenterButtonOn(window)
    center_button = window.append(UIButton, :center_button).on(:touch) do |sender|
      hideMenu
    end.get

    margin = 5
    icon_size = rmq.stylesheet.center_button_size + margin * 2
    center_button.layer.cornerRadius = icon_size / 2
    icon = FAKIonIcons.ios7PlusIconWithSize icon_size
    icon.addAttribute(NSForegroundColorAttributeName, value: rmq.color.from_hex('#FF6549'))
    iconImage = icon.imageWithSize(CGSizeMake(icon_size, icon_size))
    iconImage = iconImage.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal)
    insets = UIEdgeInsetsMake(-margin, -margin, -margin, -margin)
    center_button.setImageEdgeInsets(insets)
    center_button.setImage(iconImage, forState: UIControlStateNormal)
    center_button
  end

  def buildMenuButtonOn(window, type)
    button = window.append(UIButton, type).animations.fade_in.on(:touch) do |sender|
      puts "#{type} tapped"
      open_post_controller(sender)
    end.get

    button_size = rmq.stylesheet.menu_button_size
    button.layer.cornerRadius = button_size / 2
    button.layer.shadowOpacity = 0.2
    button.layer.shadowOffset = CGSizeMake(1, 1)

    inset = 8
    iconSize = (button_size - inset*2)*2

    case type
    when :photo
      icon = FAKIonIcons.cameraIconWithSize iconSize
      btnColor = rmq.color.from_hex('#333333')
    when :movie
      icon = FAKIonIcons.videocameraIconWithSize iconSize
      btnColor = rmq.color.from_hex('#2c3e50')
    when :text
      icon = FAKIonIcons.editIconWithSize iconSize
      btnColor = rmq.color.from_hex('#1abd9d')
    when :location
      icon = FAKIonIcons.locationIconWithSize iconSize
      btnColor = rmq.color.from_hex('#2980b9')
    when :music
      icon = FAKIonIcons.musicNoteIconWithSize iconSize
      btnColor = rmq.color.from_hex('#e67e22')
    when :greeting
      icon = FAKIonIcons.clockIconWithSize iconSize
      btnColor = rmq.color.from_hex('#8e44ad')
    end

    icon.addAttribute(NSForegroundColorAttributeName, value: btnColor)
    iconImage = icon.imageWithSize(CGSizeMake(iconSize, iconSize))
    iconImage = iconImage.imageWithRenderingMode(UIImageRenderingModeAlwaysOriginal)
    button.setImage(iconImage, forState: UIControlStateNormal)
    button.imageEdgeInsets = UIEdgeInsetsMake(inset, inset, inset, inset)
    button
  end

  def rotate_animation(toValue, bounciness)
    anim = POPSpringAnimation.animationWithPropertyNamed(KPOPLayerRotation)
    anim.toValue = toValue
    anim.springSpeed = 5
    anim.springBounciness = bounciness
    anim
  end

  def menu_item_animation_x(event, type, delay)
    case event
    when :show
      anim = POPSpringAnimation.animationWithPropertyNamed(KPOPLayerPositionX)
      anim.springBounciness = 10
      anim.springSpeed = 15
      anim.toValue = menu_item_pos_x(type)
      anim.beginTime = CACurrentMediaTime() + delay
      anim
    when :hide
      anim = POPSpringAnimation.animationWithPropertyNamed(KPOPLayerPositionX)
      anim.springBounciness = 0
      anim.springSpeed = 30
      anim.toValue = rmq.stylesheet.menu_initial_frame_x + rmq.stylesheet.menu_button_size/2
      anim.beginTime = CACurrentMediaTime() + delay + 0.15
      anim
    end
  end

  def menu_item_animation_y(event, type, delay)
    case event
    when :show
      anim = POPSpringAnimation.animationWithPropertyNamed(KPOPLayerPositionY)
      anim.springBounciness = 10
      anim.springSpeed = 15
      anim.toValue = menu_item_pos_y(type)
      anim.beginTime = CACurrentMediaTime() + delay
      anim
    when :hide
      anim = POPSpringAnimation.animationWithPropertyNamed(KPOPLayerPositionY)
      anim.springBounciness = 0
      anim.springSpeed = 30
      anim.toValue = rmq.stylesheet.menu_initial_frame_y + rmq.stylesheet.menu_button_size/2
      anim.beginTime = CACurrentMediaTime() + delay + 0.15
      anim
    end
  end

  def fadeout_animation_with_delay(delay)
    anim = POPBasicAnimation.animationWithPropertyNamed(KPOPLayerOpacity)
    anim.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseInEaseOut)
    anim.fromValue = 1
    anim.toValue = 0
    anim.beginTime = CACurrentMediaTime() + delay
    anim
  end

  def menu_item_pos_x(type)
    deg = menu_item_degree(type)
    rad = deg * Math::PI / 180
    radius = rmq.stylesheet.menu_distance_from_center_button
    x = radius * Math.cos(rad)
    case type
    when :photo,:movie,:text
      rmq.device.width/2 - x
    when :location,:music,:greeting
      rmq.device.width/2 + x
    end
  end

  def menu_item_pos_y(type)
    deg = menu_item_degree(type)
    rad = deg * Math::PI / 180
    radius = rmq.stylesheet.menu_distance_from_center_button
    y = radius * Math.sin(rad)
    rmq.device.height - y - rmq.stylesheet.menu_button_size
  end

  def menu_item_degree(type)
    case type
    when :photo, :greeting then 22.5
    when :movie, :music    then 49.5
    when :text, :location  then 76.5
    end
  end

  def open_post_controller(selected_menu)
    @showed = false

    rmq.wrap(rmq.app.window).find(:center_button).remove

    rmq.wrap(rmq.app.window).find(:overlay_menu).animate(
      duration: 0.6,
      animations: -> (q) {
        q.style { |st| st.opacity = 0 }
      },
      completion: -> (did_finish, q) {
        q.remove
      }
    )

    [:photo, :movie, :text, :location, :music, :greeting].each_with_index do |type, i|
      menu_button = rmq.wrap(rmq.app.window).find(type).get
      unless menu_button == selected_menu
        rmq(menu_button).animate(
          duration: 0.2,
          animations: -> (q) {
            q.style { |st| st.opacity = 0 }
          },
          completion: -> (did_finish, q) {
            q.remove
          }
        )
      end
    end

    selected_menu.setBackgroundColor rmq.color.clear

    anim = POPDecayAnimation.animationWithPropertyNamed(KPOPLayerSize)
    anim.velocity = NSValue.valueWithCGSize(CGSizeMake(100, 100))
    selected_menu.layer.pop_addAnimation(anim, forKey: "scale_selected_menu")

    fadeAnim = fadeout_animation_with_delay(0.2)
    fadeAnim.completionBlock = -> (anim, finished) {
      rmq(selected_menu).remove
      controller = PostController.new
      post_controller = UINavigationController.alloc.initWithRootViewController(controller)
      @parentVC.selectedViewController.presentViewController(post_controller, animated:true, completion:nil)
    }
    selected_menu.layer.pop_addAnimation(fadeAnim, forKey: "fade_selected_menu")
  end

end
