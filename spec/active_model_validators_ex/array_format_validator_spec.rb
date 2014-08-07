require 'spec_helper'

describe ArrayFormatValidator do
  describe '.new' do
    context 'when key :with is not present in argument hash' do
      let(:options) { { attributes: :something } }

      it 'raises error' do
        expect do
          ArrayFormatValidator.new(options)
        end.to raise_error
      end
    end
  end
end