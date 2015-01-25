module Eldr
  module Sessions
    def session
      env['rack.session']
    end

    def session_id
      configuration.session_id ||= ENV['SESSION_ID']
      raise StandardError, 'Set a session id!' unless configuration.session_id
      configuration.session_id
    end

    def user_model_obj
      @_user_model_obj ||= configuration.user_model.constantize unless configuration.user_model.nil?
      @_user_model_obj ||= 'User'.constantize if defined?('User')
    end

    def login_from_session
      return nil unless session
      user_model_obj.find_by_id(session[session_id]) if user_model_obj
    end

    def current_user
      @current_user ||= login_from_session
    end

    def current_user=(user)
      session[session_id] = user ? user.id : nil
      @current_user = user
    end
    alias_method :set_current_user, :current_user=

    def signed_in?
      !current_user.nil?
    end
  end
end
