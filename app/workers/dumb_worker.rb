class DumbWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform()
    puts "HELLO I AM A DUMB WORKER BEEP BOOP"
  end
end