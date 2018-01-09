class DumbWorker
  include Sidekiq::Worker

  def perform()
    puts "HELLO I AM A DUMB WORKER BEEP BOOP"
    user = User.first
    puts user.name if user
  end
end