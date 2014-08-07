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
    shared_examples_for :default_options_with_in_key_empty do
      it_behaves_like :default
      it_behaves_like :allow_nil_false

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

    shared_examples_for :default do
      context 'when passed value is a non nil, non array value' do
        let(:value) { :symbol }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end
    end

    shared_examples_for :allow_nil_true do
      context 'when passed value is nil' do
        let(:value) { nil }

        it 'does not set error messages in record' do
          expect(record.errors[attribute].count).to eq(0)
        end
      end
    end

    shared_examples_for :allow_nil_false do
      context 'when passed value is nil' do
        let(:value) { nil }

        it 'sets error message in record' do
          expect(record.errors[attribute].count).to eq(1)
        end
      end
    end

    let(:record)    { MockRecord.new(attribute) }
    let(:attribute) { :array }
    let(:validator) { ArrayInclusionValidator.new(options) }
    before { validator.validate_each(record, attribute, value) }

    context 'for instance initialized with options hash ' \
            'in with empty array as value' do
      let(:options) { { attributes: attribute, in: [] } }

      it_behaves_like :default_options_with_in_key_empty

      context 'and allow_empty as true' do

      end

      context 'and allow_nil as false' do
        it_behaves_like :default_options_with_in_key_empty
      end

      context 'and allow_nil as true' do
        let(:options) { { attributes: attribute, in: [], allow_nil: true } }

        it_behaves_like :default
        it_behaves_like :allow_nil_true

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
    end

    context 'for instance initialized with options hash ' \
            'key :in with array with values as value' do
      context 'and allow_nil as true' do
        let(:in_array) { [1, 2, 3] }
        let(:options) do
          { attributes: attribute, in: in_array, allow_nil: true }
        end

        it_behaves_like :default
        it_behaves_like :allow_nil_true

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

      context 'and allow_nil as false' do
        let(:in_range) { 1..3 }
        let(:options) do
          { attributes: attribute, in: in_range, allow_nil: false }
        end

        it_behaves_like :default
        it_behaves_like :allow_nil_false

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
end