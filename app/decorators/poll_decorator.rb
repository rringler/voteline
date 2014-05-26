class PollDecorator < Draper::Decorator
  delegate_all

  def vote_histogram
    LazyHighCharts::HighChart.new('spline') do |f|
      f.chart(height: 400, width: 600)
      f.plot_options(pointStart: js_date(Time.zone.at(object.start))) if object.votes.any?
      f.xAxis(type: 'datetime',
              #min: Time.zone.at(js_date(object.start)),
              #max: Time.zone.at(js_date(object.finish)),
              labels: { format: "{value:%l:%M %p}",
                        align: 'right',
                        rotation: -30 })
      f.yAxis(title: { text: 'Value' },
              min: object.vote_min,
              max: object.vote_max)
      f.series(name: 'Votes',
               type: 'line',
               tooltip: { useHTML: true,
                          xDateFormat: '%a, %e-%b' },
               data: high_charts_scatter_data)
      f.legend(enabled: false)

      #Rails.logger.info("INFO: HC Data: #{high_charts_scatter_data}")
    end
  end

  def pretty_start
    pretty_date(start)
  end

  def pretty_finish
    pretty_date(finish)
  end

  def pretty_created_at
    pretty_date(created_at)
  end

  private

  def high_charts_scatter_data
    @data ||= Array(object.votes).map { |x| [js_date(Time.zone.at(x.created_at)), x.value.to_i] }
  end

  def js_date(date)
    # JS stores dates as the number of milliseconds after epoch,
    # while Ruby stores dates as the number of full seconds
    (date.to_f * 1000).to_i
  end

  def pretty_date(date)
    date.strftime('%-d-%b-%Y: %l:%M %P')
  end
end
