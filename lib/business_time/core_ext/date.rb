# Add workday and weekday concepts to the Date class
class Date
  def workday?(config)
    self.weekday?(config) && !config.holidays.include?(self)
  end
  
  def weekday?(config)
    config.weekdays.include? self.wday
  end
  
  def business_days_until(to_date, config)
    (self...to_date).select{ |day| day.workday?(config) }.size
  end
end