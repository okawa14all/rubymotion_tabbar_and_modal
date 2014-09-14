class PostMenuControllerStylesheet < ApplicationStylesheet
  # Add your view stylesheets here. You can then override styles if needed, example:

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.frame = { l: 0, t: 0, w: app_width, h: app_height }
    st.background_color = color.clear
  end

  # def overlay_menu(st)
  #   st.frame = :full
  #   st.background_color = color.from_rgba(0, 0, 0, 0.8)
  # end
  #
  # def menu_button_size
  #   38
  # end
  # 
  # def menu_button(st)
  #   st.background_color = color.white
  # end
  #
  # def photo(st)
  #   menu_button(st)
  #   st.frame = { l: 35, t: 460, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def movie(st)
  #   menu_button(st)
  #   st.frame = { l: 65, t: 412, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def text(st)
  #   menu_button(st)
  #   st.frame = { l: 115, t: 300, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def location(st)
  #   menu_button(st)
  #   st.frame = { l: 165, t: 300, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def music(st)
  #   menu_button(st)
  #   st.frame = { l: 215, t: 300, w: menu_button_size, h: menu_button_size }
  # end
  #
  # def greeting(st)
  #   menu_button(st)
  #   st.frame = { l: 265, t: 300, w: menu_button_size, h: menu_button_size }
  # end

end
