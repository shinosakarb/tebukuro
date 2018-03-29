module SerializerHelper
  def serialize(resource, opts = {})
    serializer = described_class.new(resource, opts)
    ActiveModelSerializers::Adapter.create(serializer).to_json
  end
end

RSpec.configure do |config|
  config.include SerializerHelper, type: :serializer
end
