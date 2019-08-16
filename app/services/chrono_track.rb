class ChronoTrack
  include HTTParty

  base_uri 'https://api.chronotrack.com/api'

  def initialize(username:, password:, client_id:)
    @client_id = client_id

    @headers = {
      'Authorization' => "Basic #{Base64.encode64("#{username}:#{password}")}",
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }
  end

  def event_entries(event_id, options={})
    res = self.class.get("/event/#{event_id}/entry", headers: @headers, query: merge_query(options));

    OpenStruct.new(
      {
        body: res.code == 200 ? res.parsed_response['event_entry'] : res.parsed_response,
        code: res.code,
      }.merge(paginate(res.headers))
    )
  end

  def entry(entry_id, options = {})
    res = self.class.get("/entry/#{entry_id}", headers: @headers, query: merge_query(options));

    OpenStruct.new(
      {
        body: res.code == 200 ? res.parsed_response['entry'] : res.parsed_response,
        code: res.code,
      }
    )
  end

  def entry_results(entry_id, options = {})
    res = self.class.get("/entry/#{entry_id}/results", headers: @headers, query: merge_query(options));

    OpenStruct.new(
      {
        body: res.code == 200 ? res.parsed_response['entry_results'] : res.parsed_response,
        code: res.code,
      }
    )
  end

  private

    def merge_query(query = {})
      query.merge(client_id: @client_id)
    end

    def paginate(headers)
      page_count = headers['X-Ctlive-Page-Count'].to_i
      current_page = headers['X-Ctlive-Current-Page'].to_i

      {
        current_page: current_page,
        page_count: page_count,
        last_page: current_page == page_count,
      }
    end

    def connection
      @connection ||= begin
        Faradey.new.tap do |conn|
          conn
        end
      end
    end
end