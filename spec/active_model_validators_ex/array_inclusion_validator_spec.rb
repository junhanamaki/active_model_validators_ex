require 'spec_helper'

describe ArrayInclusionValidator do
  class RecordMock
    attr_accessor
  end

  describe '#validate_each' do
    context 'nil value and allow_nil true' do
      before { @instance = TestNilModel.new }

      it 'instance is valid' do
        expect(@instance.valid?).to eq(true)
      end
    end

    context 'nil value and allow_nil false' do
      before { @instance = TestNonNilModel.new }

      it 'instance is invalid' do
        expect(@instance.valid?).to eq(false)
      end
    end

    context 'value existing in range' do
      let(:attributes) { { test: [1] } }
      before { @instance = TestInRangeModel.new(attributes) }

      it 'instance is valid' do
        expect(@instance.valid?).to eq(true)
      end
    end

    context 'value does not exist in range' do
      let(:attributes) { { test: [10] } }
      before { @instance = TestInRangeModel.new(attributes) }

      it 'instance is invalid' do
        expect(@instance.valid?).to eq(false)
      end
    end

    context 'value existing in array' do
      let(:attributes) { { test: [1] } }
      before { @instance = TestInArrayModel.new(attributes) }

      it 'instance is valid' do
        expect(@instance.valid?).to eq(true)
      end
    end

    context 'value does not exist in array' do
      let(:attributes) { { test: [10] } }
      before { @instance = TestInArrayModel.new(attributes) }

      it 'instance is invalid' do
        expect(@instance.valid?).to eq(false)
      end
    end
  end
end