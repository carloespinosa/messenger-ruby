module Messenger
  module Parameters
    class Message
      include Callback

      attr_accessor :mid, :seq, :sticker_id, :text, :attachments, :quick_reply, :is_echo, :app_id, :metadata

      def initialize(mid:, seq:, sticker_id: nil, text: nil, nlp: nil, tags: nil, attachments: nil, quick_reply: nil, is_echo: nil, app_id: nil, metadata: nil)
        @mid         = mid
        @seq         = seq
        @sticker_id  = sticker_id if sticker_id.present?
        @text        = text if text.present?
        @attachments = build_attachments(attachments) if attachments.present?
        @quick_reply = build_quick_reply(quick_reply) if quick_reply.present?
        @is_echo     = is_echo
        @app_id      = app_id
        @metadata    = metadata
        @nlp         = nlp
        @tags        = tags
      end

      def build_attachments(attachments)
        attachments.map { |attachment| Attachment.new(attachment.transform_keys(&:to_sym).slice(:type, :payload)) }
      end

      def build_quick_reply(quick_reply)
        QuickReply.new(quick_reply.transform_keys(&:to_sym))
      end
    end
  end
end
