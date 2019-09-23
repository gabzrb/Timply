class Contact < MailForm::Base

  attribute :prenom,    :validate  => true
  attribute :name, :validate => true
  attribute :entreprise, :validate => false
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true



  def headers
    {
      :subject => "Contact Form",
      :to => "contact@timply.fr",
      :from => %("#{prenom}" "#{name}" <#{email}>),

    }
  end
end
