class AdminMailerPreview < ActionMailer::Preview

  def update_email
  	AdminMailer.update_email(Admin.first, Admin.last)
  end

  def method_name
  	AdminMailer.send_message(Admin.first.email, Admin.last.email, "Subject Test", "Lorem Lorem")
  end

end