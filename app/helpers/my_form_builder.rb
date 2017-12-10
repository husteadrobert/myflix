class MyFormBuilder < ActionView::Helpers::FormBuilder
  def email_field(method, text=nil, options={}, &block)
    binding.pry
    errors = object.errors[method.to_sym]
    if errors
      text += "<span class=\"error\">#{errors.first}</span>"
    end
    super(method, text.html_safe, options, &block)
  end
end