# frozen_string_literal: true

# Convert html table to key-value list
class HtmlTable
  class << self
    def to_array(table)
      rows = get_rows(table)
      headers = get_headers(table)

      is_empty_row = ->(row) { row.first == :"" }

      rows.map { |row| headers.zip(row).reject(&is_empty_row).to_h }
    end

    private

    def get_headers(table)
      to_cells(table, 'th').first.map(&method(:to_camel_case_sym))
    end

    def get_rows(table)
      to_cells(table, 'td').reject(&:empty?)
    end

    def to_camel_case_sym(text)
      text.tr(' ', '_').underscore.to_sym
    end

    def to_cells(table, selector)
      table.css('tr').map do |row|
        row.css(selector).map do |cell|
          cell.text.strip.gsub(/\s{2,}|\n/, ' ')
        end
      end
    end
  end
end
