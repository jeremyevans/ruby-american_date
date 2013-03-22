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

  specify "should ignore preceding whitespace" do
    Date.parse('  01/02/2003').should == Date.new(2003, 1, 2)
  end

  specify "should ignore preceding weekday" do
    Date.parse('Day 01/02/2003').should == Date.new(2003, 1, 2)
  end

  specify "should work just like 1.8 does" do
    Date.parse('10:20:30something01/02/2003else').should == Date.new(2003, 1, 2)
  end

  specify "should not mismatch years" do
    Date.parse('2003/01/02').should == Date.new(2003, 1, 2)
  end

  specify "should behave like 1.8 and only allow / as delimiters in american-style dates" do
    Date.parse("10/11/2012").should == Date.new(2012, 10, 11)
    Date.parse("10-11-2012").should == Date.new(2012, 11, 10)
    Date.parse("10.11.2012").should == Date.new(2012, 11, 10)
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{Date.parse(x)}.should raise_error(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      Date.parse(o).should == Date.new(2003, 1, 2)
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{Date.parse(o)}.should raise_error(TypeError)
    end
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

  specify "should ignore preceding whitespace" do
    DateTime.parse('  01/02/2003').should == DateTime.new(2003, 1, 2)
  end

  specify "should ignore preceding weekday" do
    DateTime.parse('Day 01/02/2003').should == Date.new(2003, 1, 2)
  end

  specify "should work with times" do
    DateTime.parse('01/02/2003 10:20:30').should == DateTime.new(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with times and weekdays" do
    DateTime.parse('Day 01/02/2003 10:20:30').should == DateTime.new(2003, 1, 2, 10, 20, 30)
  end

  specify "should work just like 1.8 does" do
    DateTime.parse('10:20:30something01/02/2003else').should == DateTime.new(2003, 1, 2, 10, 20, 30)
  end

  specify "should not mismatch years" do
    DateTime.parse('2003/01/02').should == Date.new(2003, 1, 2)
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{DateTime.parse(x)}.should raise_error(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      DateTime.parse(o).should == DateTime.new(2003, 1, 2)
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{DateTime.parse(o)}.should raise_error(TypeError)
    end
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

  specify "should ignore preceding whitespace" do
    Time.parse('  01/02/2003').should == Time.local(2003, 1, 2)
  end

  specify "should ignore preceding weekdays" do
    Time.parse('Day 01/02/2003').should == Time.local(2003, 1, 2)
  end

  specify "should work with times" do
    Time.parse('01/02/2003 10:20:30').should == Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with times and weekdays" do
    Time.parse('Day 01/02/2003 10:20:30').should == Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with time first and date second" do
    Time.parse('10:20:30 01/02/2003').should == Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with time first and date second and weekday in the middle" do
    Time.parse('10:20:30 Thu 01/02/2003').should == Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work just like 1.8 does" do
    Time.parse('10:20:30something01/02/2003else').should == Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should not mismatch years" do
    Time.parse('2003/01/02').should == Time.local(2003, 1, 2, 0, 0, 0)
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{Time.parse(x)}.should raise_error(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      Time.parse(o).should == Time.local(2003, 1, 2)
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{Time.parse(o)}.should raise_error(TypeError)
    end
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

  specify "should ignore preceding whitespace" do
    Date._parse('  01/02/2003').should == {:year=>2003, :mon=>1, :mday=>2}
  end

  specify "should work with times" do
    DateTime._parse('01/02/2003 10:20:30').should == {:year=>2003, :mon=>1, :mday=>2, :hour=>10, :min=>20, :sec=>30}
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{DateTime._parse(x)}.should raise_error(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      DateTime._parse(o).should == {:year=>2003, :mon=>1, :mday=>2}
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{DateTime._parse(o)}.should raise_error(TypeError)
    end
  end
end
