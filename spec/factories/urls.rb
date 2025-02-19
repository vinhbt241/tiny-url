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
FactoryBot.define do
  factory :url do
    identifier { 'foobar' }
    url { Faker::Internet.url }
  end
end
