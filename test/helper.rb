require 'thread'
require 'rubygems'

if RUBY_VERSION >= '1.9'
  require 'time'
  require 'date'
  require 'active_support/time'
else
  require 'active_support'
  require 'active_support/core_ext'
end

require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'business_time'

class Test::Unit::TestCase
  def setup
    @config = BusinessTime::Config.new
    @config.beginning_of_workday = '9:00 am'
    @config.end_of_workday = '5:00 pm'
    @config.work_week = %w[mon tue wed thu fri]
    @config.work_hours = {}
    @config.holidays = []
  end

  def teardown
    @config = nil
  end
end
