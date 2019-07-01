# frozen_string_literal: true

module GreeterHelper
  def formatted_time(time)
    # Time string in AM/PM format
    time.strftime('%I:%M%p')
  end
end
