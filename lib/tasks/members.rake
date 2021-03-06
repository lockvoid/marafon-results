require 'colorize'

namespace :members do
  desc "Import members"

  task import: :environment do
    chronotrack = ChronoTrack.new(username: ENV['CHRONOTRACK_USERNAME'], password: ENV['CHRONOTRACK_PASSWORD'], client_id: ENV['CHRONOTRACK_CLIENT_ID'])

    current_page = 1
    total_members = 0

    loop do
      puts "Request members on page #{current_page}".magenta

      res = chronotrack.event_entries(ENV['CHRONOTRACK_EVENT_ID'], {  page: current_page, size: 1000 })

      if res.code != 200
        puts "An error has occured while importing data:".red
        puts res

        raise 1
      end

      puts "Import members on page #{current_page}".magenta

      res.body.each do |member_data, index|
        Member.where(chronotrack_id: member_data['entry_id'], chronotrack_event_id: member_data['event_id']).first_or_initialize.tap do |member|
          member.update(name: member_data["entry_name"], chronotrack_tag: member_data["entry_tag"], chronotrack_bib: member_data["entry_bib"])
        end

        total_members += 1

        puts "Imported #{total_members}" if (total_members % 100) == 0
      end

      current_page += 1

      if res.last_page
        break
      end
    end

    puts "#{total_members} imported successfully!".green
  end
end
