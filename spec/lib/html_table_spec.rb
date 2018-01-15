# frozen_string_literal: true

require 'rails_helper'
require 'html_table'

describe HtmlTable do
  describe '#to_array' do
    subject { described_class.to_array(html) }

    let(:doc) { file_fixture('wiki/artifacts_table.html').read }
    let(:html) { Nokogiri::HTML(doc) }
    let(:expected) do
      {
        level: '1',
        weight: '1 ton',
        load_in: '20s',
        research_in: '2h',
        exp: '100',
        credits: '1000 - 1400',
        hydrogen: '200 - 240',
        salvage: 'C 160 H 44',
        crystal_cost: '30'
      }
    end

    its(:first) { is_expected.to eq expected }
    its(:length) { is_expected.to eq 7 }
  end
end
