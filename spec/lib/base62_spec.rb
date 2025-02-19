# frozen_string_literal: true

require 'base62'

RSpec.describe Base62 do
  describe '.encode' do
    context 'with valid input' do
      it 'encodes 0 to "0"' do
        expect(described_class.encode(0)).to eq('0')
      end

      it 'encodes small positive integers correctly', :aggregate_failures do
        expect(described_class.encode(1)).to eq('1')
        expect(described_class.encode(10)).to eq('A')
        expect(described_class.encode(61)).to eq('z')
      end

      it 'encodes larger integers correctly', :aggregate_failures do
        expect(described_class.encode(62)).to eq('10')
        expect(described_class.encode(12_345)).to eq('3D7')
        expect(described_class.encode(987_654_321)).to eq('14q60P')
      end
    end

    context 'with invalid input' do
      it 'raises ArgumentError for non-integer input', :aggregate_failures do
        expect { described_class.encode('string') }.to raise_error(ArgumentError, 'Input must be an integer.')
        expect { described_class.encode(12.34) }.to raise_error(ArgumentError, 'Input must be an integer.')
        expect { described_class.encode(nil) }.to raise_error(ArgumentError, 'Input must be an integer.')
      end

      it 'raises no error for valid integers' do
        expect { described_class.encode(123) }.not_to raise_error
      end
    end
  end
end
