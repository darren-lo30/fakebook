module NumberFormatter
  def number_to_abbreviated_string(num)
    ActionController::Base.helpers.number_to_human(num, format: "%n%u", precision: 2, significant: false, units: {thousand: "K", million: "M", billion: "B"})
  end
end