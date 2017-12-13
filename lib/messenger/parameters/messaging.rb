module Messenger
  module Parameters
    class Messaging
      attr_accessor :sender_id, :recipient_id, :nlp, :callback

      def initialize(sender:, recipient:, timestamp: nil, message: nil, delivery: nil, postback: nil, optin: nil, read: nil, account_linking: nil)
        @sender_id    = sender['id']
        @recipient_id = recipient['id']
        @nlp          = message['nlp']
        @callback     = set_callback(message: message, delivery: delivery, postback: postback, optin: optin, read: read, account_linking: account_linking)
      end

      def set_callback(callbacks)
        type = callbacks.select { |_, v| v.present? }.keys.first
        @callback = constant(type).new(callbacks[type].transform_keys(&:to_sym))
      end

      private

      def constant(symbol)
        "Messenger::Parameters::#{symbol.to_s.camelize}".constantize
      end
    end
  end
end
