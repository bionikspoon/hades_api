# frozen_string_literal: true

require 'rails_helper'

describe Wiki::Api, type: :services do
  describe '#get' do
    subject! do
      stub_request(:get, 'https://hades-star.wikia.com/wiki/artifacts')
    end

    before { described_class.get('/artifacts') }

    it { is_expected.to have_been_requested }
  end
end
