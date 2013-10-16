require_relative 'helper'

class TestTimeWithZoneExtensions < Test::Unit::TestCase
  
  context 'With Eastern Standard Time' do
    setup do
      Time.zone = 'Eastern Time (US & Canada)'
    end
    
    should 'know what a weekend day is' do
      assert( Time.weekday?(Time.zone.parse('April 9, 2010 10:30am'), @config))
      assert(!Time.weekday?(Time.zone.parse('April 10, 2010 10:30am'), @config))
      assert(!Time.weekday?(Time.zone.parse('April 11, 2010 10:30am'), @config))
      assert( Time.weekday?(Time.zone.parse('April 12, 2010 10:30am'), @config))
    end
  
    should 'know a weekend day is not a workday' do
      assert( Time.workday?(Time.zone.parse('April 9, 2010 10:45 am'), @config))
      assert(!Time.workday?(Time.zone.parse('April 10, 2010 10:45 am'), @config))
      assert(!Time.workday?(Time.zone.parse('April 11, 2010 10:45 am'), @config))
      assert( Time.workday?(Time.zone.parse('April 12, 2010 10:45 am'), @config))
    end
  
    should 'know a holiday is not a workday' do
      @config.holidays << Date.parse('July 4, 2010')
      @config.holidays << Date.parse('July 5, 2010')
    
      assert(!Time.workday?(Time.zone.parse('July 4th, 2010 1:15 pm'), @config))
      assert(!Time.workday?(Time.zone.parse('July 5th, 2010 2:37 pm'), @config))
    end
  
  
    should 'know the beginning of the day for an instance' do
      first = Time.zone.parse('August 17th, 2010, 11:50 am')
      expecting = Time.zone.parse('August 17th, 2010, 9:00 am')
      assert_equal expecting, Time.beginning_of_workday(first, @config)
    end
  
    should 'know the end of the day for an instance' do
      first = Time.zone.parse('August 17th, 2010, 11:50 am')
      expecting = Time.zone.parse('August 17th, 2010, 5:00 pm')
      assert_equal expecting, Time.end_of_workday(first, @config)
    end
  end
  
  
  context 'With UTC Timezone' do
    setup do
      Time.zone = 'UTC'
    end
    
    should 'know what a weekend day is' do
      assert( Time.weekday?(Time.zone.parse('April 9, 2010 10:30am'), @config))
      assert(!Time.weekday?(Time.zone.parse('April 10, 2010 10:30am'), @config))
      assert(!Time.weekday?(Time.zone.parse('April 11, 2010 10:30am'), @config))
      assert( Time.weekday?(Time.zone.parse('April 12, 2010 10:30am'), @config))
    end
  
    should 'know a weekend day is not a workday' do
      assert( Time.workday?(Time.zone.parse('April 9, 2010 10:45 am'), @config))
      assert(!Time.workday?(Time.zone.parse('April 10, 2010 10:45 am'), @config))
      assert(!Time.workday?(Time.zone.parse('April 11, 2010 10:45 am'), @config))
      assert( Time.workday?(Time.zone.parse('April 12, 2010 10:45 am'), @config))
    end
  
    should 'know a holiday is not a workday' do
      @config.holidays << Date.parse('July 4, 2010')
      @config.holidays << Date.parse('July 5, 2010')
    
      assert(!Time.workday?(Time.zone.parse('July 4th, 2010 1:15 pm'), @config))
      assert(!Time.workday?(Time.zone.parse('July 5th, 2010 2:37 pm'), @config))
    end
  
  
    should 'know the beginning of the day for an instance' do
      first = Time.zone.parse('August 17th, 2010, 11:50 am')
      expecting = Time.zone.parse('August 17th, 2010, 9:00 am')
      assert_equal expecting, Time.beginning_of_workday(first, @config)
    end
  
    should 'know the end of the day for an instance' do
      first = Time.zone.parse('August 17th, 2010, 11:50 am')
      expecting = Time.zone.parse('August 17th, 2010, 5:00 pm')
      assert_equal expecting, Time.end_of_workday(first, @config)
    end
  end
  
end
