class PrettyJsonResponse

  def initialize(app)
    @app = app
  end

  def call(env)
    @status, @headers, @response = @app.call(env)
    [@status, @headers, self]
  end

  def each(&block)
    @response.each do |body|
      if @headers["Content-Type"] =~ /^application\/json/
        body = pretty_print(body)
      end
      block.call(body)
    end
  end

  private

  def pretty_print(json)
    obj = JSON.parse(json)
    JSON.pretty_generate(obj)
  end

end
