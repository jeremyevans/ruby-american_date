require File.join(File.dirname(File.dirname(File.expand_path(__FILE__))), 'lib', 'american_date')
require 'time'
require 'rubygems'
ENV['MT_NO_PLUGINS'] = '1' # Work around stupid autoloading of plugins
require 'minitest/autorun'

describe "Date.parse" do
  specify "should use american date format for dd/mm/yy" do
    Date.parse('01/02/03', true).must_equal Date.new(2003, 1, 2)
    Date.parse('01/02/03', true, Date::ITALY).must_equal Date.new(2003, 1, 2)
  end

  specify "should use american date format for d/m/yy" do
    Date.parse('1/2/03', true).must_equal Date.new(2003, 1, 2)
    Date.parse('1/2/03', false).must_equal Date.new(3, 1, 2)
  end

  specify "should use american date format for dd/mm/yyyy" do
    Date.parse('01/02/2003').must_equal Date.new(2003, 1, 2)
  end

  specify "should use american date format for dd/mm" do
    Date.parse('01/02').must_equal Date.new(Time.now.year, 1, 2)
  end

  specify "should use american date format for d/m" do
    Date.parse('1/2').must_equal Date.new(Time.now.year, 1, 2)
  end

  specify "should ignore preceding whitespace" do
    Date.parse('  01/02/2003').must_equal Date.new(2003, 1, 2)
  end

  specify "should ignore preceding weekday" do
    Date.parse('Day 01/02/2003').must_equal Date.new(2003, 1, 2)
  end

  specify "should work just like 1.8 does" do
    Date.parse('10:20:30something01/02/2003else').must_equal Date.new(2003, 1, 2)
  end

  specify "should not mismatch years" do
    Date.parse('2003/01/02').must_equal Date.new(2003, 1, 2)
  end

  specify "should behave like 1.8 and only allow / as delimiters in american-style dates" do
    Date.parse("10/11/2012").must_equal Date.new(2012, 10, 11)
    Date.parse("10-11-2012").must_equal Date.new(2012, 11, 10)
    Date.parse("10.11.2012").must_equal Date.new(2012, 11, 10)
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{Date.parse(x)}.must_raise(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      Date.parse(o).must_equal Date.new(2003, 1, 2)
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{Date.parse(o)}.must_raise(TypeError)
    end
  end
end

describe "DateTime.parse" do
  specify "should use american date format for dd/mm/yy" do
    DateTime.parse('01/02/03', true).must_equal DateTime.new(2003, 1, 2)
    DateTime.parse('01/02/03', true, DateTime::ITALY).must_equal DateTime.new(2003, 1, 2)
  end

  specify "should use american date format for d/m/yy" do
    DateTime.parse('1/2/03', true).must_equal DateTime.new(2003, 1, 2)
    DateTime.parse('1/2/03', false).must_equal DateTime.new(3, 1, 2)
  end

  specify "should use american date format for dd/mm/yyyy" do
    DateTime.parse('01/02/2003').must_equal DateTime.new(2003, 1, 2)
  end

  specify "should use american date format for dd/mm" do
    DateTime.parse('01/02').must_equal DateTime.new(Time.now.year, 1, 2)
  end

  specify "should use american date format for d/m" do
    DateTime.parse('1/2').must_equal DateTime.new(Time.now.year, 1, 2)
  end

  specify "should ignore preceding whitespace" do
    DateTime.parse('  01/02/2003').must_equal DateTime.new(2003, 1, 2)
  end

  specify "should ignore preceding weekday" do
    DateTime.parse('Day 01/02/2003').must_equal Date.new(2003, 1, 2)
  end

  specify "should work with times" do
    DateTime.parse('01/02/2003 10:20:30').must_equal DateTime.new(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with times and weekdays" do
    DateTime.parse('Day 01/02/2003 10:20:30').must_equal DateTime.new(2003, 1, 2, 10, 20, 30)
  end

  specify "should work just like 1.8 does" do
    DateTime.parse('10:20:30something01/02/2003else').must_equal DateTime.new(2003, 1, 2, 10, 20, 30)
  end

  specify "should not mismatch years" do
    DateTime.parse('2003/01/02').must_equal Date.new(2003, 1, 2)
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{DateTime.parse(x)}.must_raise(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      DateTime.parse(o).must_equal DateTime.new(2003, 1, 2)
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{DateTime.parse(o)}.must_raise(TypeError)
    end
  end
end

describe "Time.parse" do
  specify "should use american date format for dd/mm/yy" do
    Time.parse('01/02/03').must_equal Time.local(2003, 1, 2)
  end

  specify "should use american date format for d/m/yy" do
    Time.parse('1/2/03').must_equal Time.local(2003, 1, 2)
  end

  specify "should use american date format for dd/mm/yyyy" do
    Time.parse('01/02/2003').must_equal Time.local(2003, 1, 2)
  end

  specify "should use american date format for dd/mm" do
    Time.parse('01/02').must_equal Time.local(Time.now.year, 1, 2)
  end

  specify "should use american date format for d/m" do
    Time.parse('1/2').must_equal Time.local(Time.now.year, 1, 2)
  end

  specify "should ignore preceding whitespace" do
    Time.parse('  01/02/2003').must_equal Time.local(2003, 1, 2)
  end

  specify "should ignore preceding weekdays" do
    Time.parse('Day 01/02/2003').must_equal Time.local(2003, 1, 2)
  end

  specify "should work with times" do
    Time.parse('01/02/2003 10:20:30').must_equal Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with times and weekdays" do
    Time.parse('Day 01/02/2003 10:20:30').must_equal Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with time first and date second" do
    Time.parse('10:20:30 01/02/2003').must_equal Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work with time first and date second and weekday in the middle" do
    Time.parse('10:20:30 Thu 01/02/2003').must_equal Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should work just like 1.8 does" do
    Time.parse('10:20:30something01/02/2003else').must_equal Time.local(2003, 1, 2, 10, 20, 30)
  end

  specify "should not mismatch years" do
    Time.parse('2003/01/02').must_equal Time.local(2003, 1, 2, 0, 0, 0)
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{Time.parse(x)}.must_raise(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      Time.parse(o).must_equal Time.local(2003, 1, 2)
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{Time.parse(o)}.must_raise(TypeError)
    end
  end
end

describe "Date._parse" do
  specify "should use american date format for dd/mm/yy" do
    Date._parse('01/02/03', true).must_equal(:year=>2003, :mon=>1, :mday=>2)
  end

  specify "should use american date format for d/m/yy" do
    Date._parse('1/2/03', true).must_equal(:year=>2003, :mon=>1, :mday=>2)
    Date._parse('1/2/03', false).must_equal(:year=>3, :mon=>1, :mday=>2)
  end

  specify "should use american date format for dd/mm/yyyy" do
    Date._parse('01/02/2003').must_equal(:year=>2003, :mon=>1, :mday=>2)
  end

  specify "should use american date format for dd/mm" do
    Date._parse('01/02').must_equal(:mon=>1, :mday=>2)
  end

  specify "should use american date format for d/m" do
    Date._parse('1/2').must_equal(:mon=>1, :mday=>2)
  end

  specify "should ignore preceding whitespace" do
    Date._parse('  01/02/2003').must_equal(:year=>2003, :mon=>1, :mday=>2)
  end

  specify "should work with times" do
    DateTime._parse('01/02/2003 10:20:30').must_equal(:year=>2003, :mon=>1, :mday=>2, :hour=>10, :min=>20, :sec=>30)
  end

  if RUBY_VERSION > '1.9'
    specify "should raise TypeError for invalid values" do
      [nil, 1, 1.0, [], {}].each do |x|
        proc{DateTime._parse(x)}.must_raise(TypeError)
      end
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() '01/02/2003' end
      DateTime._parse(o).must_equal(:year=>2003, :mon=>1, :mday=>2)
    end

    specify "should handle values implicitly convertible to String" do
      o = Object.new
      def o.to_str() 1 end
      proc{DateTime._parse(o)}.must_raise(TypeError)
    end
  end
end
