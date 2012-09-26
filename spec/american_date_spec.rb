require File.join(File.dirname(File.dirname(File.expand_path(__FILE__))), 'lib', 'american_date')
require 'time'

describe "Date.parse" do
  specify "should use american date format for dd/mm/yy" do
    Date.parse('01/02/03', true).should == Date.new(2003, 1, 2)
  end

  specify "should use american date format for d/m/yy" do
    Date.parse('1/2/03', true).should == Date.new(2003, 1, 2)
    Date.parse('1/2/03', false).should == Date.new(3, 1, 2)
  end

  specify "should use american date format for dd/mm/yyyy" do
    Date.parse('01/02/2003').should == Date.new(2003, 1, 2)
  end

  specify "should use american date format for dd/mm" do
    Date.parse('01/02').should == Date.new(Time.now.year, 1, 2)
  end

  specify "should use american date format for d/m" do
    Date.parse('1/2').should == Date.new(Time.now.year, 1, 2)
  end

  specify "should use american date format for dd-mm-yy" do
    Date.parse('01-02-03', true).should == Date.new(2003, 1, 2)
  end

  specify "should use american date format for d-m-yy" do
    Date.parse('1-2-03', true).should == Date.new(2003, 1, 2)
    Date.parse('1-2-03', false).should == Date.new(3, 1, 2)
  end

  specify "should use american date format for dd-mm-yyyy" do
    Date.parse('01-02-2003').should == Date.new(2003, 1, 2)
  end

  # Note - I tried creating the following specs for dates with dashes but no year, but they do no work.
  #
  # * should use american date format for dd-mm
  # * "should use american date format for d-m
  #
  # What happens is the short format of these dates (i.e. 1/2 or 1-2) does not match the AMERICAN_DATE_RE reqular expression. 
  # The convert_american_to_iso method just returns the input string unchanged because of this, and it just so happens that 
  # the base Date.parse method works on two digit dates with the format "1/2" but not with the format "1-2", so the tests
  # for the d/m year-less formats work.
  #
  # The same goes for the DateTime.parse, Time.parse and Date._parse tests for those year-less formats.

  specify "should ignore preceding whitespace" do
    Date.parse('  01/02/2003').should == Date.new(2003, 1, 2)
    Date.parse('  01-02-2003').should == Date.new(2003, 1, 2)
  end
end

describe "DateTime.parse" do
  specify "should use american date format for dd/mm/yy" do
    DateTime.parse('01/02/03', true).should == DateTime.new(2003, 1, 2)
  end

  specify "should use american date format for d/m/yy" do
    DateTime.parse('1/2/03', true).should == DateTime.new(2003, 1, 2)
    DateTime.parse('1/2/03', false).should == DateTime.new(3, 1, 2)
  end

  specify "should use american date format for dd/mm/yyyy" do
    DateTime.parse('01/02/2003').should == DateTime.new(2003, 1, 2)
  end

  specify "should use american date format for dd/mm" do
    DateTime.parse('01/02').should == DateTime.new(Time.now.year, 1, 2)
  end

  specify "should use american date format for d/m" do
    DateTime.parse('1/2').should == DateTime.new(Time.now.year, 1, 2)
  end

  specify "should use american date format for dd-mm-yy" do
    DateTime.parse('01-02-03', true).should == DateTime.new(2003, 1, 2)
  end

  specify "should use american date format for d-m-yy" do
    DateTime.parse('1-2-03', true).should == DateTime.new(2003, 1, 2)
    DateTime.parse('1-2-03', false).should == DateTime.new(3, 1, 2)
  end

  specify "should use american date format for dd-mm-yyyy" do
    DateTime.parse('01-02-2003').should == DateTime.new(2003, 1, 2)
  end

  specify "should ignore preceding whitespace" do
    DateTime.parse('  01/02/2003').should == DateTime.new(2003, 1, 2)
    DateTime.parse('  01-02-2003').should == DateTime.new(2003, 1, 2)
  end

  specify "should work with times" do
    DateTime.parse('01/02/2003 10:20:30').should == DateTime.new(2003, 1, 2, 10, 20, 30)
  end
end

describe "Time.parse" do
  specify "should use american date format for dd/mm/yy" do
    Time.parse('01/02/03', true).should == Time.local(2003, 1, 2)
  end

  specify "should use american date format for d/m/yy" do
    Time.parse('1/2/03', true).should == Time.local(2003, 1, 2)
  end

  specify "should use american date format for dd/mm/yyyy" do
    Time.parse('01/02/2003').should == Time.local(2003, 1, 2)
  end

  specify "should use american date format for dd/mm" do
    Time.parse('01/02').should == Time.local(Time.now.year, 1, 2)
  end

  specify "should use american date format for d/m" do
    Time.parse('1/2').should == Time.local(Time.now.year, 1, 2)
  end

  specify "should use american date format for dd-mm-yy" do
    Time.parse('01-02-03', true).should == Time.local(2003, 1, 2)
  end

  specify "should use american date format for d-m-yy" do
    Time.parse('1-2-03', true).should == Time.local(2003, 1, 2)
  end

  specify "should use american date format for dd-mm-yyyy" do
    Time.parse('01-02-2003').should == Time.local(2003, 1, 2)
  end

  specify "should ignore preceding whitespace" do
    Time.parse('  01/02/2003').should == Time.local(2003, 1, 2)
  end

  specify "should work with times" do
    Time.parse('01/02/2003 10:20:30').should == Time.local(2003, 1, 2, 10, 20, 30)
    Time.parse('01-02-2003 10:20:30').should == Time.local(2003, 1, 2, 10, 20, 30)
  end
end

describe "Date._parse" do
  specify "should use american date format for dd/mm/yy" do
    Date._parse('01/02/03', true).should == {:year=>2003, :mon=>1, :mday=>2}
  end

  specify "should use american date format for d/m/yy" do
    Date._parse('1/2/03', true).should == {:year=>2003, :mon=>1, :mday=>2}
    Date._parse('1/2/03', false).should == {:year=>3, :mon=>1, :mday=>2}
  end

  specify "should use american date format for dd/mm/yyyy" do
    Date._parse('01/02/2003').should == {:year=>2003, :mon=>1, :mday=>2}
  end

  specify "should use american date format for dd/mm" do
    Date._parse('01/02').should == {:mon=>1, :mday=>2}
  end

  specify "should use american date format for d/m" do
    Date._parse('1/2').should == {:mon=>1, :mday=>2}
  end
  
  specify "should use american date format for dd-mm-yy" do
    Date._parse('01-02-03', true).should == {:year=>2003, :mon=>1, :mday=>2}
  end

  specify "should use american date format for d-m-yy" do
    Date._parse('1-2-03', true).should == {:year=>2003, :mon=>1, :mday=>2}
    Date._parse('1-2-03', false).should == {:year=>3, :mon=>1, :mday=>2}
  end

  specify "should use american date format for dd-mm-yyyy" do
    Date._parse('01-02-2003').should == {:year=>2003, :mon=>1, :mday=>2}
  end

  specify "should ignore preceding whitespace" do
    Date._parse('  01/02/2003').should == {:year=>2003, :mon=>1, :mday=>2}
    Date._parse('  01-02-2003').should == {:year=>2003, :mon=>1, :mday=>2}
  end

  specify "should work with times" do
    DateTime._parse('01/02/2003 10:20:30').should == {:year=>2003, :mon=>1, :mday=>2, :hour=>10, :min=>20, :sec=>30}
    DateTime._parse('01-02-2003 10:20:30').should == {:year=>2003, :mon=>1, :mday=>2, :hour=>10, :min=>20, :sec=>30}
  end
end
