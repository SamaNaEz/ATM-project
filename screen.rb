# Show a message
class Screen

  def display_line_message(message)
    print message
  end

  def display_text_highlighted_sup(message)
    print "\n==================================\n#{message}"
  end

  def display_text_highlighted_inf(message)
    print "\n#{message}\n==================================\n"
  end

  def display_text_highlighted(message)
    print"\n==================================\n"
    print message
    print"\n==================================\n"
  end
end
