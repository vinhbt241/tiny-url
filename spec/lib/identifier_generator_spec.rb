# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IdentifierGenerator do
  describe '.generate_identifier' do
    it 'generate unique identifier based on timestamp, machine ID and sequence number' do
      allow(ENV).to receive(:fetch).with('MACHINE_ID', 1).and_return(1)
      allow(Time).to receive(:current).and_return(DateTime.new(2025, 2, 19, 1, 1, 1))

      expect(described_class.generate_identifier).to eq('h9V5378cK')
    end

    it 'generates unique identifiers' do
      identifiers = Array.new(5) { described_class.generate_identifier }
      expect(identifiers.uniq.size).to eq(5)
    end

    it 'ensures sequential uniqueness within the same timestamp' do
      allow(Time).to receive(:current).and_return(DateTime.new(2025, 2, 19, 1, 1, 1))

      id1 = described_class.generate_identifier
      id2 = described_class.generate_identifier

      expect(id1).not_to eq(id2)
    end
  end
end
