require 'spec_helper'

describe ArrayInclusionValidator do
  describe '.new' do
    context 'when key :in is not present in argument hash' do
      let(:options) { { attributes: :something } }

      it 'raises error' do
        expect do
          ArrayInclusionValidator.new(options)
        end.to raise_error
      end
    end
  end

  describe '#validate_each' do
    let(:record)    { MockRecord.new(attribute) }
    let(:attribute) { :array }
    let(:validator) { ArrayInclusionValidator.new(options) }
    before { validator.validate_each(record, attribute, value) }

    context 'for instance initialized with options hash ' \
            'key :in with empty array as value' do
      let(:options) { { attributes: attribute, in: [] } }

      context 'when passed value is nil' do
        let(:value) { nil }

        it 'sets error message in record, under passed attribute key' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is a non nil, non array value' do
        let(:value) { :symbol }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is an empty array' do
        let(:value) { [] }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is an array with values' do
        let(:value) { [1, 2, 3] }

        it 'sets error message in record, under passed attribute key' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end
    end

    context 'for instance initialized with options hash ' \
            'key :in with empty array as value, ' \
            'allow_nil as false' do
      let(:options) { { attributes: attribute, in: [], allow_nil: false } }

      context 'when passed value is nil' do
        let(:value) { nil }

        it 'sets error message in record, under passed attribute key' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is a non nil, non array value' do
        let(:value) { :symbol }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is an empty array' do
        let(:value) { [] }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is an array with values' do
        let(:value) { [1, 2, 3] }

        it 'sets error message in record, under passed attribute key' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end
    end

    context 'for instance initialized with options hash ' \
            'key :in with empty array as value, ' \
            'allow_nil as true' do
      let(:options) { { attributes: attribute, in: [], allow_nil: true } }

      context 'when passed value is nil' do
        let(:value) { nil }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is a non nil, non array value' do
        let(:value) { :symbol }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is an empty array' do
        let(:value) { [] }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is an array with values' do
        let(:value) { [1, 2, 3] }

        it 'sets error message in record, under passed attribute key' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end
    end

    context 'for instance initialized with options hash ' \
            'key :in with array with values as value, ' \
            'allow_nil as true' do
      let(:in_array) { [1, 2, 3] }
      let(:options)  { { attributes: attribute, in: in_array, allow_nil: true } }

      context 'when passed value is nil' do
        let(:value) { nil }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is a non nil, non array value' do
        let(:value) { :symbol }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is an empty array' do
        let(:value) { [] }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is an array with values that are in options array' do
        let(:value) { [1, 2, 3] }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is an array with values not in options array' do
        let(:value) { [4, 5, 6] }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end
    end

    context 'for instance initialized with options hash ' \
            'key :in with range with values as value, ' \
            'allow_nil as false' do
      let(:in_range) { 1..3 }
      let(:options)  { { attributes: attribute, in: in_range, allow_nil: false } }

      context 'when passed value is nil' do
        let(:value) { nil }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is a non nil, non array value' do
        let(:value) { :symbol }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end

      context 'when passed value is an empty array' do
        let(:value) { [] }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is an array with values that are in options range' do
        let(:value) { [1, 2, 3] }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end

      context 'when passed value is an array with values not in options range' do
        let(:value) { [4, 5, 6] }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end
    end
  end
end