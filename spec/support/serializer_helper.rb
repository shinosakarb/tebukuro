module SerializerHelper
  def serialize(resource, opts={})
    serializer = described_class.new(resource)
    ActiveModelSerializers::Adapter.create(serializer, opts).to_json
  end

  def serialize_with_json_api(resource, opts={})
    serialize_opts = {adapter: :json_api}.reverse_merge(opts)
    serialize(resource, serialize_opts)
  end
end
