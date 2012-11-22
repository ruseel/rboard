
desc "seed many topic at board specified by ENV[\"BOARD\"]"
task :seed_topics => :environment do
  b=Board.where(acronym: ENV["BOARD"]).first
  if b.nil?
    raise StandardError.new("no such board with name(#{ENV["BOARD"]})")
  end

  0.upto 100 do |n|
    b.topics.create(subject: "topic #{n}", body: "topic #{n} body")
  end
end