class DumbWorker
  include Sidekiq::Worker

  def perform()
    puts "HELLO I AM A DUMB WORKER BEEP BOOP"
  end
end