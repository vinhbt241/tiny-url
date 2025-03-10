# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id         :bigint           not null, primary key
#  identifier :string           not null
#  url        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_urls_on_identifier  (identifier) UNIQUE
#  index_urls_on_url         (url) UNIQUE
#
require 'rails_helper'

RSpec.describe Url, type: :model do
  subject(:url) { create(:url) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:identifier) }
    it { is_expected.to validate_uniqueness_of(:identifier) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }

    context 'when url format is invalid' do
      let(:url) { build(:url, url: 'invalid-url') }

      it 'includes an error message' do
        url.valid?
        expect(url.errors[:url]).to include('must be a valid URL starting with http or https')
      end
    end

    context 'when url appears to be malicious' do
      let(:url) { build(:url, url: "https://malicious-url.com?q=<script>alert('XSS')</script>") }

      it 'includes an error message' do
        url.valid?
        expect(url.errors[:url]).to include('contains potentially malicious content or an invalid scheme')
      end
    end
  end
end
