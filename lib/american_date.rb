require 'date'

if RUBY_VERSION >= '1.9'
  # Modify parsing methods to handle american date format correctly.
  class << Date
    # American date format detected by the library.
    AMERICAN_DATE_RE = eval('%r_(?<!\d)(\d{1,2})/(\d{1,2})/(\d{4}|\d{2})(?!\d)_').freeze
    # Negative lookbehinds, which are not supported in Ruby 1.8
    # so by using eval, we prevent an error when this file is first parsed
    # since the regexp itself will only be parsed at runtime if the RUBY_VERSION condition is met.

    # Alias for stdlib Date._parse
    alias _parse_without_american_date _parse

    # Transform american dates into ISO dates before parsing.
    def _parse(string, comp=true)
      _parse_without_american_date(convert_american_to_iso(string), comp)
    end

    if RUBY_VERSION >= '1.9.3'
      # Alias for stdlib Date.parse
      alias parse_without_american_date parse

      # Transform american dates into ISO dates before parsing.
      def parse(string, comp=true)
        parse_without_american_date(convert_american_to_iso(string), comp)
      end
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
      string.sub(AMERICAN_DATE_RE){|m| "#$3-#$1-#$2"}
    end
  end

  if RUBY_VERSION >= '1.9.3'
    # Modify parsing methods to handle american date format correctly.
    class << DateTime
      # Alias for stdlib Date.parse
      alias parse_without_american_date parse

      # Transform american dates into ISO dates before parsing.
      def parse(string, comp=true)
        parse_without_american_date(convert_american_to_iso(string), comp)
      end
    end
  end
end
