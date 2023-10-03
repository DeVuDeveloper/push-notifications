module ApplicationHelper
  def form_error_notification(object)
    return unless object.errors.any?

    tag.div class: "text-red-500 ml-8" do
      object.errors.full_messages.to_sentence.capitalize
    end
  end

  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end
end
