class PollDecorator < Draper::Decorator
  delegate_all

  def vote_histogram
    LazyHighCharts::HighChart.new('spline') do |f|
      f.chart(height: 400, width: 600)
      f.plot_options(pointStart: js_date(object.start))
      f.xAxis(type: 'datetime',
              min: js_date(object.start),
              max: js_date(object.finish),
              labels: { format: "#{date_format_string}",
                        align: 'right',
                        rotation: -30 })
      f.yAxis(title: { text: 'Value' },
              min: object.vote_min,
              max: object.vote_max)
      f.series(name: 'Avg. Vote',
               type: 'line',
               tooltip: { useHTML: true,
                          xDateFormat: '%a, %e-%b' })
      f.legend(enabled: false)
      f.options[:chart][:events] = { load: load_data_via_ajax.js_code }
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

  def load_data_via_ajax
    if object.live?
      <<-END
        function requestData(){
          $.ajax({url:'#{object.id}/binned_votes.json', success: function(data){
            console.log(data);
            window.chart_vote_histogram_chart.series[0].setData(data);
            setTimeout(requestData,5000)
          }, cache: false});
        }
      END
    else
      <<-END
        function requestData(){
          $.ajax({url:'#{object.id}/binned_votes.json', success: function(data){
            console.log(data);
            window.chart_vote_histogram_chart.series[0].setData(data);
          }, cache: false});
        }
      END
    end
  end

  def date_format_string
    if object.start.day == object.finish.day
      "{value:%l:%M %p}"
    else
      "{value:%b-%e<br/>%l:%M %p}"
    end
  end

  def js_date(date)
    # JS stores dates as the number of milliseconds after UTC epoch,
    # while Ruby stores dates as the number of full seconds
    ((date + date.utc_offset).to_f * 1000).to_i
  end

  def pretty_date(date)
    date.strftime('%-d-%b-%Y: %l:%M %P')
  end
end
