# frozen_string_literal: true

require 'rails_helper'

describe Wiki do
  describe '#artifacts' do
    subject { described_class.artifacts.first }

    before do
      stub_request(:get, 'https://hades-star.wikia.com/wiki/artifacts')
        .to_return(status: 200, headers: {}, body: body)
    end

    let(:body) { file_fixture('wiki/artifacts.html').read }
    let(:expected) do
      {
        level: 1,
        weight: 1,
        load_in: 20.seconds,
        research_in: 2.hours,
        exp: 100,
        credits: 1000..1400,
        hydrogen: 200..240,
        salvage: { credits: 160, hydrogen: 44 },
        crystal_cost: 30
      }
    end

    it { is_expected.to eq(expected) }
  end
end
