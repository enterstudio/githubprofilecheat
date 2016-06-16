# -*- coding: utf-8 -*-
require 'date'

# Inspired by
# █████████████████████████
# █ ███ █     █  ████  ████
# █ ███ ███ ███  ████  ████
# █ █ █ ███ ███  ████  ████
# █ █ █ ███ ███  ████  ████
# █     █     █     █     █
# █████████████████████████

#52x7
PATTERN = <<-EOF.split("\n").map{|line| line.split(//)}.transpose.map(&:join).join
   ###    ######## ##     ##  #######   ######  
  ## ##      ##    ###   ### ##     ## ##    ## 
 ##   ##     ##    #### #### ##     ## ##       
##     ##    ##    ## ### ## ##     ##  ######  
#########    ##    ##     ## ##     ##       ## 
##     ##    ##    ##     ## ##     ## ##    ## 
##     ##    ##    ##     ##  #######   ######  
EOF

MASK = PATTERN.split(//).map{|c| c != '#'}

DAYSTART = Date.new(2015,05,24)
DAYEND   = DAYSTART + (PATTERN.size*4)


dates = DAYSTART.upto( DAYEND ).to_a

def on?(date)
  delta = (date - DAYSTART).to_i
  MASK[ delta % MASK.size ]
end

commit_dates = []
dates.each do |date|
  if on?(date)
    22.times{|i| commit_dates << date.to_time + i*3600}
  end
end

str_commit_dates = commit_dates.map(&:to_s)

commit_dates.each do |date|
  puts date
  File.open('random_list_of_dates', 'w') { |f| f << str_commit_dates.shuffle.first(12).join("\n") }
  `GIT_AUTHOR_DATE="#{date}" GIT_COMMITTER_DATE="#{date}" git commit -am "#{date}"`
end
