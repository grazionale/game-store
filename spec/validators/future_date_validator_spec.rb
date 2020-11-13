require "rails_helper"

# Classe utilizada apenas para poder simular o teste do FutureDateValidator
class Validatable
  include ActiveModel::Validations # é o módulo responsável por fazer as validações dentro de um model do Rails
  attr_accessor :date
  validates :date, future_date: true # future_date é o nome do arquivo validators/future_date_validator.rb
end

describe FutureDateValidator do
  subject { Validatable.new } # Desta forma o subject do RSpec vai ser a instância da classe que a gente criou lá em cima

  context "when date is before current date" do
    before { subject.date = 1.day.ago } # antes de executar os testes
  
    it "should be invalid" do
      expect(subject.valid?).to be_falsey
    end
    
    it "adds an error on model" do
      subject.valid?
      expect(subject.errors.keys).to include(:date)
    end
  end

  context "when date is equal current date" do
    before { subject.date = Time.zone.now }

    it "should be invalid" do
      expect(subject.valid?).to be_falsey
    end

    it "adds an error on model" do
      subject.valid?
      expect(subject.errors.keys).to include(:date)
    end
  end

  context "when date is greater than current date" do
    before { subject.date = Time.zone.now + 1.day }

    it "should be valid" do
      expect(subject.valid?).to be_truthy
    end
  end
end
