class PagesController < ApplicationController
  def result
    @last_tag = get_last_tag

    if @last_tag
      @member = Member.where(chronotrack_tag: @last_tag).first

      if @member
        @entry = chronotrack.entry(@member.chronotrack_id)

        if @entry.code == 404
          flash.now.alert = 'Данных еще нет. Обратись к администрации или попробуйте чуть позже.'

          return render :error
        elsif @entry.code != 200
          flash.now.alert = "Произошла ошибка #{entry.code} (#{entry.body}). Обратись к администрации или попробуйте чуть позже."

          return render :error
        end

        if @entry.body['entry_status'] == "CONF" # confirmed
          @entry_results = chronotrack.entry_results(@member.chronotrack_id, { size: 50, interval: 'all' })

          @entry_full_interval = @entry_results.body.find { |interval| interval['results_interval_full'].to_i == 1 }
          @entry_intervals = @entry_results.body.select { |interval| interval['results_interval_full'].to_i == 0 }
        end

      else
        flash.now.alert = 'Данных еще нет. Обратись к администрации или попробуйте чуть позже.'

        return render :error
      end
    else
      flash.now.alert = 'Поднесите браслет к считывающему устройству.'

      return render :error
    end
  rescue SocketError => e
    flash.now.alert = 'Отсутствует подключение к интернету'

    return render :error
  end

  private

    def get_last_tag
      unless File.file? ENV['READER_CSV_PATH']
        raise 'CSV файл не найден'
      end

      last_reader_line = `tail -n 1 #{ENV['READER_CSV_PATH']}`

      if last_reader_line.present?
        last_reader_line.split('~')[2]
      else
        nil
      end
    end

    def get_member_info

    end

    def get_member_results

    end

    def chronotrack
      @chronotrack ||= ChronoTrack.new(username: ENV['CHRONOTRACK_USERNAME'], password: ENV['CHRONOTRACK_PASSWORD'], client_id: ENV['CHRONOTRACK_CLIENT_ID'])
    end
end
