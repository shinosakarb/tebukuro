module SerializerHelper
  def serialize(resource, opts={})
    serializer = described_class.new(resource)
    ActiveModelSerializers::Adapter.create(serializer, opts).to_json
  end
end

RSpec.configure do |config|
  config.include SerializerHelper, type: :serializer
end
