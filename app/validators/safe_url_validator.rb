# frozen_string_literal: true

class SafeUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    uri = parse_uri(value)
    return unless uri.nil? || malicious_url?(uri)

    record.errors.add(attribute, options[:message] || I18n.t('activerecord.errors.messages.unsafe_url'))
  end

  private

  def parse_uri(value)
    URI.parse(value)
  rescue URI::InvalidURIError
    nil
  end

  def malicious_url?(uri)
    return true unless %w[http https].include?(uri.scheme)

    dangerous_patterns = [
      %r{<script.*?>.*?</script>}i, # Inline script tags
      /javascript:/i,               # JavaScript scheme
      /%3Cscript%3E/i,              # URL-encoded <script> tag
      /alert\(/i                    # Common alert injection
    ]

    [uri.query, uri.fragment].compact.any? do |component|
      dangerous_patterns.any? { |pattern| component.match?(pattern) }
    end
  end
end
