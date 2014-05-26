class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :poll

  scope :binned, ->(start, finish, number_of_bins = 20) do
    duration = finish.to_i - start.to_i
    step_size = (duration / number_of_bins).to_i

    bins = (start.to_i..finish.to_i).step(step_size).to_a
    puts "***\nbins: #{bins}\n***"
    puts "***\nbins size: #{bins.size}\n***"

    votes = where("created_at >= ? AND created_at <= ?", start, finish)
    puts "***\nvotes size: #{votes.size}\n***"

    grouped = votes.group_by { |vote|
                index = ((vote.created_at.to_i - start.to_i) / step_size).to_i
                puts "***\nindex: #{index}\n***"
                bins[index]
              }

    pp grouped
    grouped.each_with_object(Hash.new) { |(k,v), h|
             puts "***\nv: #{v}\n***"
             values = v.map{ |v| v.value.to_i }
             puts "***\nvalues: #{values}\n***"
             average = values.sum.to_f / values.size
             puts "***\naverage: #{average}\n***"

             h[k] = average
           }
  end

  validates :value, presence: true
end
