require 'google/apis/calendar_v3'
require 'googleauth'
require 'googleauth/stores/file_token_store'

require 'fileutils'

OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
APPLICATION_NAME = 'ACM CALENDAR'
CALENDAR_PATH = File.expand_path(File.dirname(__FILE__))
SECRETS_PATH = File.join(CALENDAR_PATH, 'secrets', 'client_secret.json')
CREDENTIALS_PATH = File.join(CALENDAR_PATH, 'credentials', 'calendar.yaml')
SCOPE = Google::Apis::CalendarV3::AUTH_CALENDAR_READONLY


client_id = Google::Auth::ClientId.from_file(SECRETS_PATH)
token_store = Google::Auth::Stores::FileTokenStore.new(file: CREDENTIALS_PATH)
authorizer = Google::Auth::UserAuthorizer.new(client_id, SCOPE, token_store)
user_id = 'default'
url = authorizer.get_authorization_url(base_url: OOB_URI)

puts "Open the following URL in the browser and enter the " +
     "resulting code after authorization"
puts url

code = gets
    
credentials = authorizer.get_and_store_credentials_from_code(
                user_id: user_id, code: code, base_url: OOB_URI)

