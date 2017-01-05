class UserMailer < ApplicationMailer
  
  def lecture_created(lecture)
    @lecture = lecture
    mail(to: lecture.email, subject: "Lecture created")
  end
  
  def exam_created(exam)
    @exam = exam
    mail(to: exam.email, subject: "Exam created")
  end
  
end
