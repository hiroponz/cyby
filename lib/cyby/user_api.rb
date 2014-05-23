module Cyby
  class UserApi
    AUTH = 'X-Cybozu-Authorization'

    include HTTParty

    def initialize
      config = YAML.load_file("#{ENV['HOME']}/.cyby.yml")
      self.class.base_uri "https://#{config['subdomain']}.cybozu.com/v1/csv"
      @auth = Base64.encode64("#{config['login']}:#{config['password']}").chomp
    end

    def get(path)
      options = { headers: { AUTH => @auth } }
      self.class.get(path, options)
    end

    def user
      get("/user.csv")
    end

    def organization
      get("/organization.csv")
    end

    def title
      get("/title.csv")
    end

    def user_organizations
      get("/userOrganizations.csv")
    end

    def group
      get("/group.csv")
    end

    def user_groups
      get("/userGroups.csv")
    end

    def user_services
      get("/userServices.csv")
    end
  end
end
