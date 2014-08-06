class MockRecord
  attr_accessor :errors

  def initialize(attribute)
    @errors = { attribute => [] }
  end
end