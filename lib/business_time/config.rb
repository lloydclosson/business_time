require 'active_support/core_ext'

module BusinessTime

  # controls the behavior of this gem.  You can change
  # the beginning_of_workday, end_of_workday, and the list of holidays
  # manually, or with a yaml file and the load method.
  class Config
    # You can set this yourself, either by the load method below, or
    # by saying
    #   BusinessTime::Config.beginning_of_workday = "8:30 am"
    # someplace in the initializers of your application.
    attr_accessor :beginning_of_workday

    # You can set this yourself, either by the load method below, or
    # by saying
    #   BusinessTime::Config.end_of_workday = "5:30 pm"
    # someplace in the initializers of your application.
    attr_accessor :end_of_workday

    # You can set this yourself, either by the load method below, or
    # by saying
    #   BusinessTime::Config.work_week = [:sun, :mon, :tue, :wed, :thu]
    # someplace in the initializers of your application.
    attr_accessor :work_week

    # You can set this yourself, either by the load method below, or
    # by saying
    #   BusinessTime::Config.holidays << my_holiday_date_object
    # someplace in the initializers of your application.
    attr_accessor :holidays

    # working hours for each day - if not set using global variables :beginning_of_workday
    # and end_of_workday. Keys will be added ad weekdays.
    # Example:
    #    {:mon => ["9:00","17:00"],:tue => ["9:00","17:00"].....}
    attr_accessor :work_hours


    def end_of_workday(day=nil)
      if day
        wday = @work_hours[int_to_wday(day.wday)]
        wday ? (wday.last =~ /0{1,2}\:0{1,2}/ ? "23:59:59" : wday.last) : @end_of_workday
      else
        @end_of_workday
      end
    end

    def beginning_of_workday(day=nil)
      if day
        wday = @work_hours[int_to_wday(day.wday)]
        wday ? wday.first : @beginning_of_workday
      else
        @beginning_of_workday
      end
    end

    def work_week=(days)
      @work_week = days
      @weekdays = nil
    end

    def weekdays
      return @weekdays unless @weekdays.nil?

      @weekdays = (!work_hours.empty? ? work_hours.keys : work_week).each_with_object([]) do |day_name, days|
        day_num = wday_to_int(day_name)
        days << day_num unless day_num.nil?
      end
    end

    def wday_to_int day_name
      lowercase_day_names = ::Time::RFC2822_DAY_NAME.map(&:downcase)
      lowercase_day_names.find_index(day_name.to_s.downcase)
    end

    def int_to_wday num
      ::Time::RFC2822_DAY_NAME.map(&:downcase).map(&:to_sym)[num]
    end
  end
end
