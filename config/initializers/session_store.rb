# Be sure to restart your server when you modify this file.


PassServiceExample::Application.config.session_store :active_record_store

module ActiveRecord
  module SessionStore
    class Session
      before_save :update_pass_session_id!
      
      def set_attribute!(key, value)
        data[key] = value
        marshal_data!
      end

      def self.find_by_pass_session_id(pass_session_id)
        where(pass_session_id: pass_session_id).first
      end

      private

      def update_pass_session_id!
        self.pass_session_id = self.data["pass_session_id"] if self.data["pass_session_id"]
      end
    end
  end
end
