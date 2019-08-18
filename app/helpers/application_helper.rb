module ApplicationHelper
  def format_time(time)
    if time
      time.split('.')[0]
    else
      '—'
    end
  end
end
