# Toda vez que um valitador é chamado como vimos, herdando da classe 
# ActiveModel::EachValidator, ele precisa implementar um método chamado validate_each.
class FutureDateValidator < ActiveModel::EachValidator
  # record que recebe o objeto do model, 
  # attribute que é o nome do atributo que está sendo validado 
  # value que é o valor do atributo no model.
  def validate_each(record, attribute, value)
    if value.present? && value <= Time.zone.now
      # Lança uma mensagem de erro || ou uma mensagem default configurada em locales/pt-BR/custom_validations.yml
      message = options[:message] || :future_date 
      record.errors.add(attribute, message)
    end
  end

end