require 'colorize'

namespace :members do
  desc "Import members"

  task import: :environment do
    chronotrack = ChronoTrack.new(username: ENV['CHRONOTRACK_USERNAME'], password: ENV['CHRONOTRACK_PASSWORD'], client_id: ENV['CHRONOTRACK_CLIENT_ID'])

    current_page = 1
    total_members = 0

    loop do
      puts "Request members on page #{current_page}".magenta

      res = chronotrack.event_entries(ENV['CHRONOTRACK_EVENT_ID'], { columns: 'entry_id,entry_name,entry_tag,entry_bib,event_id,reg_transachronotrackion_reg_time_local', page: current_page, size: 1000 })

      if res.code != 200
        puts "An error has occured while importing data:".red
        puts

        raise res.inspechronotrack
      end

      if res.last_page
        break
      end

      puts "Import members on page #{current_page}".magenta

      res.body.each do |member_data, index|
        Member.where(chronotrack_id: member_data['entry_id'], chronotrack_event_id: member_data['event_id']).first_or_initialize.tap do |member|
          member.update(name: member_data["entry_name"], chronotrack_tag: member_data["entry_tag"], chronotrack_bib: member_data["entry_bib"])
        end

        total_members += 1
      end

      current_page += 1
    end

    puts "#{total_members} imported successfully!".green
  end
end
