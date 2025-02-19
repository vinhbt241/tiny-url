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
class Url < ApplicationRecord
  # constants
  # Jan 01, 2025, 01:01:01 UTC
  TIME_EPOCH = 1_737_680_461

  # validations
  validates :long_url, presence: true, uniqueness: true

  # callbacks
  after_create :generate_short_url!

  private

  def generate_short_url!
    timestamp = DateTime.current.to_i - TIME_EPOCH
    generated_url = Base64.urlsafe_encode64([timestamp, id.to_i].join)

    self[:short_url] = generated_url
  end
end
