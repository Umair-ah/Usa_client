module ApplicationHelper

  def color_scheme(status)
    case status
    when "pending" then "color: #e800ff;"
    when "out for delivery" then "color: #0045ff;"
    when "completed" then "color: #18e526;"
    when "cancelled" then "color: #ff0000;"

    end

  end
end
