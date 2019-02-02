class Contact < MailForm::Base

  attribute :prenom,    :validate  => true
  attribute :name, :validate => true
  attribute :entreprise, :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true



  def headers
    {
      :subject => "Contact Form",
      :to => "gabrielzerbib6@gmail.com",
      :from => %("#{prenom}" "#{name}" <#{email}>)
    }
  end
end
