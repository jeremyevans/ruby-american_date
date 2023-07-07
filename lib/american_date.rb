require 'date'

# :nocov:
if RUBY_VERSION >= '1.9'
# :nocov:
  long_date = ' ' * 128 + '2021-10-11'
  limit_supported = begin
    Date.parse(long_date)
  rescue ArgumentError
    (Date.parse(long_date, true, Date::ITALY, :limit=>nil) == Date.new(2021, 10, 11)) rescue false
  # :nocov:
  else
    false
  # :nocov:
  end

  # American date format detected by the library.
  Date::AMERICAN_DATE_RE = eval('%r_(?<!\d)(\d{1,2})/(\d{1,2})/(\d{4}|\d{2})(?!\d)_').freeze
  # Negative lookbehinds, which are not supported in Ruby 1.8
  # so by using eval, we prevent an error when this file is first parsed
  # since the regexp itself will only be parsed at runtime if the RUBY_VERSION condition is met.

  # Modify parsing methods to handle american date format correctly.
  Date.instance_eval do

    # Alias for stdlib Date._parse
    alias _parse_without_american_date _parse

    if limit_supported
      instance_eval(<<-END, __FILE__, __LINE__+1)
        def _parse(string, comp=true, limit: 128)
          _parse_without_american_date(convert_american_to_iso(string), comp, limit: limit)
        end
      END
    # :nocov:
    else
      # Transform american dates into ISO dates before parsing.
      def _parse(string, comp=true)
        _parse_without_american_date(convert_american_to_iso(string), comp)
      end
    # :nocov:
    end

    # :nocov:
    if RUBY_VERSION >= '1.9.3'
    # :nocov:
      # Alias for stdlib Date.parse
      alias parse_without_american_date parse

      if limit_supported
        instance_eval(<<-END, __FILE__, __LINE__+1)
          def parse(string, comp=true, start=Date::ITALY, limit: 128)
            parse_without_american_date(convert_american_to_iso(string), comp, start, limit: limit)
          end
        END
      # :nocov:
      else
        # Transform american dates into ISO dates before parsing.
        def parse(string, comp=true, start=Date::ITALY)
          parse_without_american_date(convert_american_to_iso(string), comp, start)
        end
      end
      # :nocov:
    end

    private

    # Transform american date fromat into ISO format.
    def convert_american_to_iso(string)
      unless string.is_a?(String)
        if string.respond_to?(:to_str)
          str = string.to_str
          unless str.is_a?(String)
            raise TypeError, "no implicit conversion of #{string.inspect} into String"
          end
          string = str
        else
          raise TypeError, "no implicit conversion of #{string.inspect} into String"
        end
      end
      string.sub(Date::AMERICAN_DATE_RE){|m| "#$3-#$1-#$2"}
    end
  end

  # :nocov:
  if RUBY_VERSION >= '1.9.3'
  # :nocov:
    # Modify parsing methods to handle american date format correctly.
    DateTime.instance_eval do
      # Alias for stdlib Date.parse
      alias parse_without_american_date parse

      if limit_supported
        instance_eval(<<-END, __FILE__, __LINE__+1)
          def parse(string, comp=true, start=Date::ITALY, limit: 128)
            parse_without_american_date(convert_american_to_iso(string), comp, start, limit: limit)
          end
        END
      # :nocov:
      else
        # Transform american dates into ISO dates before parsing.
        def parse(string, comp=true, start=Date::ITALY)
          parse_without_american_date(convert_american_to_iso(string), comp, start)
        end
      end
      # :nocov:
    end
  end
end
