class MainStylesheet < ApplicationStylesheet

  def setup
    # Add sytlesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.background_color = color.white
  end

  def hello_world(st)
    st.frame = {top: 100, width: 200, height: 20, centered: :horizontal}
    st.text_alignment = :center
    st.color = color.battleship_gray
    st.font = font.medium
    st.text = 'Timeline'
  end

  def image(st)
    st.frame = {t: 140, l: 5, width: app_width - 10, height: app_width - 10 }
    st.view.contentMode = UIViewContentModeScaleAspectFill
  end
end
