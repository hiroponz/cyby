module Cyby
  module Kintone
    class RestApi
      AUTH = 'X-Cybozu-Authorization'

      include HTTParty

      def initialize(app)
        config = YAML.load_file("#{ENV['HOME']}/.cyby.yml")
        self.class.base_uri "https://#{config['subdomain']}.cybozu.com/k/v1"
        @auth = Base64.encode64("#{config['login']}:#{config['password']}").chomp
        @app = app
      end

      def headers
        { AUTH => @auth, 'Content-Type' => 'application/json' }
      end

      def get(path, body = {})
        body.merge!(app: @app)
        options = { headers: headers, body: body.to_json }
        self.class.get(path, options)
      end

      def post(path, body = {})
        body.merge!(app: @app)
        options = { headers: headers, body: body.to_json }
        self.class.post(path, options)
      end

      def put(path, body = {})
        body.merge!(app: @app)
        options = { headers: headers, body: body.to_json }
        self.class.put(path, options)
      end

      def delete(path, body = {})
        body.merge!(app: @app)
        options = { headers: headers, body: body.to_json }
        self.class.delete(path, options)
      end
    end
  end
end
