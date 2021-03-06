require_relative 'helper'

class TestBusinessDays < Test::Unit::TestCase
  
  context 'with a TimeWithZone object set to the Eastern timezone' do
    setup do
      Time.zone = 'Eastern Time (US & Canada)'
    end
    teardown do
      Time.zone = nil
    end
    
    should 'move to tomorrow if we add a business day' do
      first = Time.zone.parse('April 13th, 2010, 11:00 am')
      later = 1.business_day(@config).after(first)
      expected = Time.zone.parse('April 14th, 2010, 11:00 am')
      assert_equal expected, later
    end

    should 'move to yesterday is we subtract a business day' do
      first = Time.zone.parse('April 13th, 2010, 11:00 am')
      before = 1.business_day(@config).before(first)
      expected = Time.zone.parse('April 12th, 2010, 11:00 am')
      assert_equal expected, before
    end

    should 'take into account the weekend when adding a day' do
      first = Time.zone.parse('April 9th, 2010, 12:33 pm')
      after = 1.business_day(@config).after(first)
      expected = Time.zone.parse('April 12th, 2010, 12:33 pm')
      assert_equal expected, after
    end

    should 'take into account the weekend when subtracting a day' do
      first = Time.zone.parse('April 12th, 2010, 12:33 pm')
      before = 1.business_day(@config).before(first)
      expected = Time.zone.parse('April 9th, 2010, 12:33 pm')
      assert_equal expected, before
    end

    should 'move forward one week when adding 5 business days' do
      first = Time.zone.parse('April 9th, 2010, 12:33 pm')
      after = 5.business_days(@config).after(first)
      expected = Time.zone.parse('April 16th, 2010, 12:33 pm')
      assert_equal expected, after
    end

    should 'move backward one week when subtracting 5 business days' do
      first = Time.zone.parse('April 16th, 2010, 12:33 pm')
      before = 5.business_days(@config).before(first)
      expected = Time.zone.parse('April 9th, 2010, 12:33 pm')
      assert_equal expected, before
    end

    should 'take into account a holiday when adding a day' do
      three_day_weekend = Date.parse('July 5th, 2010')
      @config.holidays << three_day_weekend
      friday_afternoon = Time.zone.parse('July 2nd, 2010, 4:50 pm')
      tuesday_afternoon = 1.business_day(@config).after(friday_afternoon)
      expected = Time.zone.parse('July 6th, 2010, 4:50 pm')
      assert_equal expected, tuesday_afternoon
    end

    should 'take into account a holiday on a weekend' do
      july_4 = Date.parse('July 4th, 2010')
      @config.holidays << july_4
      friday_afternoon = Time.zone.parse('July 2nd, 2010, 4:50 pm')
      monday_afternoon = 1.business_day(@config).after(friday_afternoon)
      expected = Time.zone.parse('July 5th, 2010, 4:50 pm')
      assert_equal expected, monday_afternoon
    end
  end
  
end
