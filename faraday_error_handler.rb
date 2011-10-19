module Faraday
  class Response::ErrorHandler < Response::Middleware
    extend Forwardable

    def initialize app, handler, code_is_error = proc {|c| c >= 400 }
      super(app)
      @error_handler = handler
      @code_is_error = code_is_error
    end

    def on_complete env
      s = env[:status].to_i
      if @code_is_error.call s
        @error_handler.call env, s
      end
    end
  end
end
