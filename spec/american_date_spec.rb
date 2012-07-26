require_relative '../lib/american_date'
require 'time'

describe "parsing various input" do
  let(:dd_mm_yy) { "01_02_03".gsub("_", delimiter) }
  let(:d_m_yy) { "1_2_03".gsub("_", delimiter) }
  let(:dd_mm_yyyy) { "01_02_2003".gsub("_", delimiter) }
  let(:dd_mm) { "01_02".gsub("_", delimiter) }
  let(:d_m) { "1_2".gsub("_", delimiter) }
  let(:wwwwdd_mm_yyyy) { "    01_02_2003".gsub("_", delimiter) }
  let(:date_with_time) { "01_02_2003 10:20:30".gsub("_", delimiter) }

  shared_examples_for "a parser that handles american dates" do
    specify "should use american date format for dd/mm/yy" do
      klass.parse(dd_mm_yy, true).should == klass.new(2003, 1, 2)
    end

    specify "should use american date format for d/m/yy" do
      klass.parse(d_m_yy, true).should == klass.new(2003, 1, 2)
      klass.parse(d_m_yy, false).should == klass.new(3, 1, 2)
    end

    specify "should use american date format for dd/mm/yyyy" do
      klass.parse(dd_mm_yyyy).should == klass.new(2003, 1, 2)
    end

    specify "should ignore preceding whitespace" do
      klass.parse(wwwwdd_mm_yyyy).should == klass.new(2003, 1, 2)
    end
  end

  describe Date do
    let(:klass) { Date }

    context "- delimited input" do
      let(:delimiter) { "-" }
      it_should_behave_like "a parser that handles american dates"
    end

    context "/ delimited input" do
      let(:delimiter) { "/" }
      it_should_behave_like "a parser that handles american dates"

      # stdlib' klass.parse handles 01-02 differently to 01/02
      # so only support this in the / delimiter

      specify "should use american date format for dd/mm" do
        Date.parse(dd_mm).should == Date.new(Time.now.year, 1, 2)
      end

      specify "should use american date format for d/m" do
        Date.parse(d_m).should == Date.new(Time.now.year, 1, 2)
      end
    end

    context ". delimited input" do
      let(:delimiter) { "." }
      it_should_behave_like "a parser that handles american dates"
    end
  end

  describe DateTime do
    let(:klass) { DateTime }

    context "- delimited input" do
      let(:delimiter) { "-" }

      it_should_behave_like "a parser that handles american dates"

      specify "should work with times" do
        DateTime.parse(date_with_time).should == DateTime.new(2003, 1, 2, 10, 20, 30)
      end
    end

    context "/ delimited input" do
      let(:delimiter) { "/" }

      it_should_behave_like "a parser that handles american dates"

      specify "should use american date format for dd/mm" do
        DateTime.parse(dd_mm).should == DateTime.new(Time.now.year, 1, 2)
      end

      specify "should use american date format for d/m" do
        DateTime.parse(d_m).should == DateTime.new(Time.now.year, 1, 2)
      end

      specify "should work with times" do
        DateTime.parse(date_with_time).should == DateTime.new(2003, 1, 2, 10, 20, 30)
      end
    end

    context ". delimited input" do
      let(:delimiter) { "." }

      it_should_behave_like "a parser that handles american dates"

      specify "should work with times" do
        DateTime.parse(date_with_time).should == DateTime.new(2003, 1, 2, 10, 20, 30)
      end
    end
  end

  describe Time do
    shared_examples_for "a time parser that handles american dates" do
      specify "should use american date format for dd/mm/yy" do
        Time.parse(dd_mm_yy, true).should == Time.local(2003, 1, 2)
      end

      specify "should use american date format for d/m/yy" do
        Time.parse(d_m_yy, true).should == Time.local(2003, 1, 2)
      end

      specify "should use american date format for dd/mm/yyyy" do
        Time.parse(dd_mm_yyyy).should == Time.local(2003, 1, 2)
      end

      specify "should ignore preceding whitespace" do
        Time.parse(wwwwdd_mm_yyyy).should == Time.local(2003, 1, 2)
      end

      specify "should work with times" do
        Time.parse(date_with_time).should == Time.local(2003, 1, 2, 10, 20, 30)
      end
    end

    context "with a /" do
      let(:delimiter) { "/" }

      it_behaves_like "a time parser that handles american dates"

      specify "should use american date format for dd/mm" do
        Time.parse(dd_mm).should == Time.local(Time.now.year, 1, 2)
      end

      specify "should use american date format for d/m" do
        Time.parse(d_m).should == Time.local(Time.now.year, 1, 2)
      end
    end

    context "with a -" do
      let(:delimiter) { "-" }

      it_behaves_like "a time parser that handles american dates"
    end

    context "with a ." do
      let(:delimiter) { "." }

      it_behaves_like "a time parser that handles american dates"
    end
  end

  describe "Date._parse" do
    shared_examples_for "a parser that handles american dates returning a hash" do
      specify "should use american date format for dd/mm/yy" do
        Date._parse(dd_mm_yy, true).should == {:year=>2003, :mon=>1, :mday=>2}
      end

      specify "should use american date format for d/m/yy" do
        Date._parse(d_m_yy, true).should == {:year=>2003, :mon=>1, :mday=>2}
        Date._parse(d_m_yy, false).should == {:year=>3, :mon=>1, :mday=>2}
      end

      specify "should use american date format for dd/mm/yyyy" do
        Date._parse(dd_mm_yyyy).should == {:year=>2003, :mon=>1, :mday=>2}
      end

      specify "should ignore preceding whitespace" do
        Date._parse(wwwwdd_mm_yyyy).should == {:year=>2003, :mon=>1, :mday=>2}
      end

      specify "should work with times" do
        DateTime._parse(date_with_time).should == {:year=>2003, :mon=>1, :mday=>2, :hour=>10, :min=>20, :sec=>30}
      end
    end

    context "with a /" do
      let(:delimiter) { "/" }
      it_should_behave_like "a parser that handles american dates returning a hash"

      specify "should use american date format for dd/mm" do
        Date._parse(dd_mm).should == {:mon=>1, :mday=>2}
      end

      specify "should use american date format for d/m" do
        Date._parse(d_m).should == {:mon=>1, :mday=>2}
      end
    end

    context "with a -" do
      let(:delimiter) { "-" }
      it_should_behave_like "a parser that handles american dates returning a hash"
    end

    context "with a ." do
      let(:delimiter) { "." }
      it_should_behave_like "a parser that handles american dates returning a hash"
    end
  end
end
