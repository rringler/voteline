class VoteAggregator
  def initialize(votes)
    @votes = votes
  end

  def high_charts_scatter_data(resolution: 15)
    binned_votes = binned_hash(@votes, start, finish, resolution)

    dates    = binned_votes.keys
                           .reverse
                           .map { |date| js_date(Time.at(date)) }
    averages = binned_votes.values
                           .reverse
                           .map { |value| value.to_i }

    dates.zip(averages)
  end

  private

  def binned_hash(votes, start, finish, resolution)
    bins = create_bins(start, finish, resolution)

    grouped_votes = votes.group_by do |vote|
      bins.find_all { |i| i <= vote.created_at.to_i }.last
    end

    grouped_votes.each_with_object(Hash.new) do |(k,v), h|
      vote_values = v.map { |vote| vote.value.to_i }

      h[k] = array_average(vote_values)
    end
  end

  def create_bins(start, finish, resolution)
    (start.to_i..finish.to_i).step(resolution).to_a
  end

  def array_average(array)
    array.sum.to_f / array.size
  end

  def js_date(date)
    # JS stores dates as the number of milliseconds after UTC epoch,
    # while Ruby stores dates as the number of full seconds
    ((date + date.utc_offset).to_f * 1000).to_i
  end

  def start
    @votes.map { |vote| vote.poll.start }.min
  end

  def finish
    @votes.map { |vote| vote.poll.finish }.max
  end
end
