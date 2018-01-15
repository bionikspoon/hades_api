# frozen_string_literal: true

require 'html_table'

# Get information from wiki
module Wiki
  class << self
    def artifacts
      doc = Wiki::Api.get('/artifacts').body
      html = Nokogiri::HTML(doc)

      arts = HtmlTable.to_array(html.at_css('.article-table'))
      arts.map(&method(:to_artifact))
    end

    private

    def to_artifact(obj)
      obj.transform_values(&method(:parse_values))
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength
    def parse_values(string)
      case string
      when /(\d+)\s*-\s*(\d+)/
        # range ex '100 - 200' -> 100..200
        Range.new(Regexp.last_match(1).to_i, Regexp.last_match(2).to_i)
      when /c\s*(?<credits>\d+)\s*h\s*(?<hydrogen>\d+)/i
        # cost ex 'C 200 H 300' -> {credits: 200, hydrogen: 300}
        Regexp.last_match.named_captures.symbolize_keys.transform_values(&:to_i)
      when /(\d+)s/
        # duration ex '20s' -> 20.seconds
        Regexp.last_match(1).to_i.seconds
      when /(\d+)h/
        # duration ex '2h' -> 2.hours
        Regexp.last_match(1).to_i.hours
      when /(\d+)[a-z ]/i
        # remove units ex '2 tons' -> 2
        Regexp.last_match(1).to_i
      when /(\d+)/
        # parse int ex '2' -> 2
        Regexp.last_match(1).to_i
      else
        string
      end
    end
  end
end
