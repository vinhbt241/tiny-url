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
class Url < ApplicationRecord
  # validations
  validates :identifier, presence: true, uniqueness: true
  validates :url, presence: true, uniqueness: true
  validates :url, format: {
    with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
    message: :invalid_url
  }
  validates :url, safe_url: true
end
