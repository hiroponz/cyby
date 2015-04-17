module Cyby
  module Kintone
    class RestApi
      attr_reader :app

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
        resp = self.class.get(path, options)
        if resp.code == 200
          resp
        else
          fail resp["message"]
        end
      end

      def post(path, body = {})
        body.merge!(app: @app)
        options = { headers: headers, body: body.to_json }
        resp = self.class.post(path, options)
        if resp.code == 200
          resp
        else
          fail resp["message"]
        end
      end

      def put(path, body = {})
        body.merge!(app: @app)
        options = { headers: headers, body: body.to_json }
        resp = self.class.put(path, options)
        if resp.code == 200
          resp
        else
          fail resp["message"]
        end
      end

      def delete(path, body = {})
        body.merge!(app: @app)
        options = { headers: headers, body: body.to_json }
        resp = self.class.delete(path, options)
        if resp.code == 200
          resp
        else
          fail resp["message"]
        end
      end
    end
  end
end
