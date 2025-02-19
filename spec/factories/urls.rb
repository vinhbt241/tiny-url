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
FactoryBot.define do
  factory :url do
    long_url { Faker::Internet.url }
  end
end
