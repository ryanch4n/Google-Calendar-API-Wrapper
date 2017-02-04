require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'

class Calendar

  APPLICATION_NAME = 'Google Calendar'
  CALENDAR_PATH = File.expand_path(File.dirname(__FILE__))
  SECRETS_PATH = File.join(CALENDAR_PATH, 'secrets', 'client_secret.json')
  CREDENTIALS_PATH = File.join(CALENDAR_PATH, 'credentials', 'calendar.yaml')
  SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY

  attr_reader :event_summaries, :event_start_times, :event_start_dates,
              :event_end_times

  #Get Authorization from Google     
  def authorize
    client_id = Google::Auth::ClientId.from_file(SECRETS_PATH)
    token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
    authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
    user_id = 'default'
    credentials = authorizer.get_credentials(user_id)
  end

  def initialize(calendar_id)
    @calendar = Google::Apis::CalendarV3::CalendarService.new
    @calendar.client_options.application_name = APPLICATION_NAME
    @calendar.authorization = authorize
    @calendar_id = calendar_id
  end

  #Store event information
  def getEvents
    @event_summaries = []
    @event_start_times = []
    @event_start_dates = []
    @event_end_times = []

    events = @calendar.list_events(@calendar_id, single_events: true,
                                   order_by: 'startTime', 
                                   time_min: Time.now.iso8601)

    events.items.each do |event|
      @event_summaries << event.summary if event.summary != nil
      @event_start_times << event.start.date_time.strftime("%l:%M %p") if event.start.date_time != nil
      @event_start_dates << event.start.date_time.strftime("%A, %B %e, %Y") if event.start.date_time != nil
      @event_end_times << event.end.date_time.strftime("%l:%M %p") if event.start.date_time != nil
    end
  end
end
