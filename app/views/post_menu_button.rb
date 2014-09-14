class PostMenuButton < UIButton
  attr_accessor :type

  def self.new(type)
    self.new
  end

  def rmq_created
    puts "rmq_created #{type}"
  end

  def rmq_appended
    puts "rmq_appended #{type}"
  end

  def rmq_build
    puts "rmq_appended #{type}"
    # q = rmq(self)
    # q.apply_style :post_menu_button

    # Add subviews here, like so:
    # q.append(UILabel, :some_label)
    # -or-
    # @submit_button = q.append(UIButon, :submit).get
    # -or-
    # @submit_button = q.append! UIButon, :submit
  end

  def viewWillAppear(animated)
    puts "rmq_appended #{type}"
  end

end
