module ApplicationHelper
  def form_error_notification(object)
    return unless object.errors.any?

    tag.div class: "text-red-500 ml-8" do
      object.errors.full_messages.to_sentence.capitalize
    end
  end

  def active_link_to(path, options = {}, &block)
    is_active = current_page?(path)
    active_class = is_active ? options[:active_class] : ""
    is_active ? options[:hover_class] : options[:default_hover_class]

    link_to(path, options.merge(class: "#{options[:class]} #{active_class}"), &block)
  end

  def render_turbo_stream_flash_messages
    turbo_stream.prepend "flash", partial: "layouts/flash"
  end
end
