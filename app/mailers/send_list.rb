class SendList < ActionMailer::Base
  default from: "wubtesting@gmail.com"
  
  def quick_send(list, email, sender)
    @list = list
    @sender = sender
    @email = email
    mail(to: email, reply_to: email, subject: "#{@sender.capitalize} sent you a shopping list")
  end
end
