# [Pass Service Example](http://pass-service-example.herokuapp.com)

Pass is a new, experimental authentication system. You can learn more about it [here](htts://passauth.net/about).

This is an example service for the Pass system.

## Details

To recreate this example, your Rails app needs to use database-based sessions. The default `active_record_store` needs to be replaced or monkey patched to add retrieving session by the `pass_session_id`.

```
# app/initializers/session_store.rb
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
```

### Callback Addresses

To receive updates from Pass, a number of callbacks are required. These can be found in `apps/controllers/session_controller.rb`

### Session Store Table

The sessions table needs an additional field to search based on `pass_session_id`.

```
create_table "sessions", force: true do |t|
  t.string   "session_id", null: false
  t.text     "data"
  t.datetime "created_at"
  t.datetime "updated_at"
  t.integer  "pass_session_id"
end

add_index "sessions", ["pass_session_id"], name: "index_sessions_on_pass_session_id"
add_index "sessions", ["session_id"], name: "index_sessions_on_session_id"
add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"
```