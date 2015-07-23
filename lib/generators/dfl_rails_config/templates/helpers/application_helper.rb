module ApplicationHelper
  def han(attribute)
    controller.controller_name.classify.constantize.human_attribute_name attribute rescue attribute
  end

  def navbar_item_active(controller)
    params[:controller] == controller ? 'active' : ''
  end

  def number_to_currency_br(number)
    number_to_currency(number, unit: 'R$ ', separator: ',', delimiter: '.')
  end
end