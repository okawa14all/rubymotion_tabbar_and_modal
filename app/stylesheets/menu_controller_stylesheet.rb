class MenuControllerStylesheet < ApplicationStylesheet

  include MenuCellStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def menu_close_button_size
    40
  end

  def menu_close_button_color
    color.white
  end

  def frame_view(st)
    st.frame = device.screen.applicationFrame
  end

  def close_button(st)
    st.frame = { l: 10, t: 25, w: menu_close_button_size, h: menu_close_button_size }
  end

  def table(st)
    st.frame = { l: 0, t: 160, w: app_width, h: app_height - 160 }
    st.background_color = color.clear
    st.view.showsVerticalScrollIndicator = false
  end

end
