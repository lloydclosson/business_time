require_relative 'helper'

class TestConfig < Test::Unit::TestCase

  should 'keep track of the start of the day' do
    assert_equal '9:00 am', @config.beginning_of_workday
    @config.beginning_of_workday = '8:30 am'
    assert_equal '8:30 am', @config.beginning_of_workday
  end

  should 'keep track of the end of the day' do
    assert_equal '5:00 pm', @config.end_of_workday
    @config.end_of_workday = '5:30 pm'
    assert_equal '5:30 pm', @config.end_of_workday
  end

  should 'keep track of holidays' do
    assert @config.holidays.empty?
    daves_birthday = Date.parse('August 4th, 1969')
    @config.holidays << daves_birthday
    assert @config.holidays.include?(daves_birthday)
  end

  should 'keep track of work week' do
    assert_equal %w[mon tue wed thu fri], @config.work_week
    @config.work_week = %w[sun mon tue wed thu]
    assert_equal %w[sun mon tue wed thu], @config.work_week
  end

  should 'map work week to weekdays' do
    assert_equal [1,2,3,4,5], @config.weekdays
    @config.work_week = %w[sun mon tue wed thu]
    assert_equal [0,1,2,3,4], @config.weekdays
    @config.work_week = %w[tue wed] # Hey, we got it made!
    assert_equal [2,3], @config.weekdays
  end

  should 'keep track of the start of the day using work_hours' do
    assert_equal({},@config.work_hours)
    @config.work_hours = {
      :mon=>['9:00','17:00'],
      :tue=>['9:00','17:00'],
      :thu=>['9:00','17:00'],
      :fri=>['9:00','17:00']
    }
    assert_equal({:mon=>['9:00','17:00'],
      :tue=>['9:00','17:00'],
      :thu=>['9:00','17:00'],
      :fri=>['9:00','17:00']
    }, @config.work_hours)
    assert_equal([1,2,4,5], @config.weekdays.sort)
  end
end