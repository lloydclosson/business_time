require_relative 'helper'

class TestDateExtensions < Test::Unit::TestCase
    
  should 'know a weekend day is not a workday'  do
    assert(Date.parse('April 9, 2010').workday?(@config))
    assert(!Date.parse('April 10, 2010').workday?(@config))
    assert(!Date.parse('April 11, 2010').workday?(@config))
    assert(Date.parse('April 12, 2010').workday?(@config))
  end
  
  should 'know a weekend day is not a workday (with a configured work week)'  do
    @config.work_week = %w[sun mon tue wed thu]
    assert(Date.parse('April 8, 2010').weekday?(@config))
    assert(!Date.parse('April 9, 2010').weekday?(@config))
    assert(!Date.parse('April 10, 2010').weekday?(@config))
    assert(Date.parse('April 12, 2010').weekday?(@config))
  end
  
  should 'know a holiday is not a workday' do
    july_4 = Date.parse('July 4, 2010')
    july_5 = Date.parse('July 5, 2010')
    
    assert(!july_4.workday?(@config))
    assert(july_5.workday?(@config))
    
    @config.holidays << july_4
    @config.holidays << july_5
    
    assert(!july_4.workday?(@config))
    assert(!july_5.workday?(@config))
  end
  
end