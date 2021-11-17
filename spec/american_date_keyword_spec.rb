long_date = ' ' * 128 + '01/02/2003'
limit_supported = begin
  Date.parse(long_date)
rescue ArgumentError
if ((Date.parse(long_date, true, Date::ITALY, :limit=>nil) == Date.new(2003, 1, 2)) rescue false)
describe "Date.parse" do
  specify "should not support long dates without limit keyword" do
    proc{Date.parse(long_date, true)}.must_raise ArgumentError
  end

  specify "should not support long dates with limit keyword" do
    Date.parse(long_date, true, limit: 150).must_equal Date.new(2003, 1, 2)
    Date.parse(long_date, true, limit: nil).must_equal Date.new(2003, 1, 2)
  end
end

describe "DateTime.parse" do
  long_datetime = long_date + ' 10:11:12'
  specify "should not support long dates without limit keyword" do
    proc{DateTime.parse(long_datetime, true)}.must_raise ArgumentError
  end

  specify "should not support long dates with limit keyword" do
    DateTime.parse(long_datetime, true, limit: 150).must_equal DateTime.new(2003, 1, 2, 10, 11, 12)
    DateTime.parse(long_datetime, true, limit: nil).must_equal DateTime.new(2003, 1, 2, 10, 11, 12)
  end
end

describe "Date._parse" do
  specify "should not support long dates without limit keyword" do
    proc{Date._parse(long_date, true)}.must_raise ArgumentError
  end

  specify "should not support long dates with limit keyword" do
    Date._parse(long_date, true, limit: 150).must_equal(:year=>2003, :mon=>1, :mday=>2)
    Date._parse(long_date, true, limit: nil).must_equal(:year=>2003, :mon=>1, :mday=>2)
  end
end
end
end
