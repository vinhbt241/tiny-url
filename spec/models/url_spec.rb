# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id         :bigint           not null, primary key
#  long_url   :string           not null
#  short_url  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_urls_on_long_url   (long_url) UNIQUE
#  index_urls_on_short_url  (short_url)
#
require 'rails_helper'

RSpec.describe Url, type: :model do
  subject(:url) { create(:url) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:long_url) }
    it { is_expected.to validate_uniqueness_of(:long_url) }
  end

  describe 'callbacks' do
    describe 'after create' do
      it 'generates short URL', :aggregate_failures do
        url = described_class.new(long_url: Faker::Internet.url)

        expect(url.short_url).to be_nil

        url.save!

        expect(url.short_url).to be_truthy
      end
    end
  end
end
