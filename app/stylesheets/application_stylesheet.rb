class ApplicationStylesheet < RubyMotionQuery::Stylesheet

  def application_setup

    # Change the default grid if desired
    #   rmq.app.grid.tap do |g|
    #     g.num_columns =  12
    #     g.column_gutter = 10
    #     g.num_rows = 18
    #     g.row_gutter = 10
    #     g.content_left_margin = 10
    #     g.content_top_margin = 74
    #     g.content_right_margin = 10
    #     g.content_bottom_margin = 10
    #   end

    # An example of setting standard fonts and colors
    font_family = 'HelveticaNeue-Light'
    font.add_named :large,    font_family, 36
    font.add_named :medium,   font_family, 24
    font.add_named :small,    font_family, 18

    color.add_named :tint, '236EB7'
    color.add_named :translucent_black, color.from_rgba(0, 0, 0, 0.4)
    color.add_named :battleship_gray,   '#7F7F7F'
    # color.add_named :brand_color, '#F1745D'
    color.add_named :brand_color, '#FF6549'
    color.add_named :ivory, '#FFFFF0'
    color.add_named :default_font_color, '#5b686a'

    color.add_named :black, '#000000'
    color.add_named :gray, '#808080'
  end

  def standard_button(st)
    st.frame = {w: 40, h: 18}
    st.background_color = color.tint
    st.color = color.white
  end

  def standard_label(st)
    st.frame = {w: 40, h: 18}
    st.background_color = color.clear
    st.color = color.black
  end

  def blur_image_tint_color
    color.black
  end

  def brand_color
    color.brand_color
  end

  def overlay(st)
    st.frame = :full
    st.background_color = color.from_rgba(0, 0, 0, 0.4)
  end

  def overlay_menu(st)
    st.frame = :full
    st.background_color = color.from_rgba(0, 0, 0, 0.8)
  end

  # -------------------------
  #  Post Menu
  # -------------------------
  def center_button_size
    36
  end

  def menu_button_size
    36
  end

  def center_button_offset
    5.5
  end

  def menu_distance_from_center_button
    menu_button_size * 3
  end

  def menu_button(st)
    st.background_color = color.white
  end

  def menu_initial_frame_x
    app_width/2 - menu_button_size/2
  end

  def menu_initial_frame_y
    rmq.device.height - center_button_offset - menu_button_size
  end

  def menu_initial_frame
    # { l: menu_initial_frame_x, fb: center_button_offset, w: menu_button_size, h: menu_button_size}
    { l: menu_initial_frame_x, t: menu_initial_frame_y, w: menu_button_size, h: menu_button_size}
  end

  def photo(st)
    menu_button(st)
    st.frame = menu_initial_frame
  end

  def movie(st)
    menu_button(st)
    st.frame = menu_initial_frame
  end

  def text(st)
    menu_button(st)
    st.frame = menu_initial_frame
  end

  def location(st)
    menu_button(st)
    st.frame = menu_initial_frame
  end

  def music(st)
    menu_button(st)
    st.frame = menu_initial_frame
  end

  def greeting(st)
    menu_button(st)
    st.frame = menu_initial_frame
  end

  # def photo(st)
  #   menu_button(st)
  #   rad = to_rad(22.5)
  #   a = menu_distance_from_center_button * Math.cos(rad)
  #   b = menu_distance_from_center_button * Math.sin(rad)
  #   pos_l = app_width/2 - a - menu_button_size/2
  #   pos_fb = menu_fb_offset + b - menu_button_size/2
  #   st.frame = { l: pos_l, fb: pos_fb, w: menu_button_size, h: menu_button_size }
  # end

  # def movie(st)
  #   menu_button(st)
  #   rad = to_rad(49.5)
  #   a = menu_distance_from_center_button * Math.cos(rad)
  #   b = menu_distance_from_center_button * Math.sin(rad)
  #   pos_l = app_width/2 - a - menu_button_size/2
  #   pos_fb = menu_fb_offset + b - menu_button_size/2
  #   st.frame = { l: pos_l, fb: pos_fb, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def text(st)
  #   menu_button(st)
  #   rad = to_rad(76.5)
  #   a = menu_distance_from_center_button * Math.cos(rad)
  #   b = menu_distance_from_center_button * Math.sin(rad)
  #   pos_l = app_width/2 - a - menu_button_size/2
  #   pos_fb = menu_fb_offset + b - menu_button_size/2
  #   st.frame = { l: pos_l, fb: pos_fb, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def location(st)
  #   menu_button(st)
  #   rad = to_rad(76.5)
  #   a = menu_distance_from_center_button * Math.cos(rad)
  #   b = menu_distance_from_center_button * Math.sin(rad)
  #   pos_l = app_width/2 + a - menu_button_size/2
  #   pos_fb = menu_fb_offset + b - menu_button_size/2
  #   st.frame = { l: pos_l, fb: pos_fb, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def music(st)
  #   menu_button(st)
  #   rad = to_rad(49.5)
  #   a = menu_distance_from_center_button * Math.cos(rad)
  #   b = menu_distance_from_center_button * Math.sin(rad)
  #   pos_l = app_width/2 + a - menu_button_size/2
  #   pos_fb = menu_fb_offset + b - menu_button_size/2
  #   st.frame = { l: pos_l, fb: pos_fb, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def greeting(st)
  #   menu_button(st)
  #   rad = to_rad(22.5)
  #   a = menu_distance_from_center_button * Math.cos(rad)
  #   b = menu_distance_from_center_button * Math.sin(rad)
  #   pos_l = app_width/2 + a - menu_button_size/2
  #   pos_fb = menu_fb_offset + b - menu_button_size/2
  #   st.frame = { l: pos_l, fb: pos_fb, w: menu_button_size, h: menu_button_size }
  # end

  def center_button(st)
    st.frame = { l: app_width/2 - center_button_size/2, fb: center_button_offset, w: center_button_size, h: center_button_size }
    st.background_color = color.white
  end

  def to_rad(deg)
    deg * Math::PI / 180
  end

end
