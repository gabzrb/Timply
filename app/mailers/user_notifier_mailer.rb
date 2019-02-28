
  class UserMailer < ActionMailer::Base
    default :from => 'gabrielzerbib6@gmail.com'
layout 'mailer'
    # send a signup email to the user, pass in the user object that   contains the user's email address
    def welcome_user(user)
      @user = user
      mail( :to => @user.email,
            :subject => 'Bienvenue!' )
    end
  end

