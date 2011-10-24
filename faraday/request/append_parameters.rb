module Faraday
  class Request
    class AppendParameters < Faraday::Middleware
      def call env 
        env[:url].query_values = (env[:url].query_values || {}).merge(@params)
        @app.call env 
      end 

      def initialize(app, params)
        @app = app 
        @params = params
      end 
    end 
  end 
end
