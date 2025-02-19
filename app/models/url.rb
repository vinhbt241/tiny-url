# frozen_string_literal: true

# == Schema Information
#
# Table name: urls
#
#  id         :bigint           not null, primary key
#  identifier :string           not null
#  long_url   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_urls_on_identifier  (identifier) UNIQUE
#  index_urls_on_long_url    (long_url) UNIQUE
#
class Url < ApplicationRecord
  # validations
  validates :identifier, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true
end
