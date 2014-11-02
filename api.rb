require "excon"
require "json"

GEEMUS_ID       = "3C6F7394-D76F-11E0-8D0C-B466AFC32CB1"
ISRU_ID         = "DEEA08AE-DB30-11E0-BD96-B466AFC32CB1"
ROOT_FOLDER_ID  = "3CD903AE-D76F-11E0-81BD-B366AFC32CB1"

@conn = Excon.new("https://www.thegamecrafter.com/")
@session_id = JSON.parse(
  @conn.request(
    :method => :post,
    :path   => "/api/session",
    :query  => {
      "api_key_id"  => ENV["THE_GAME_CRAFTER_API_KEY"],
      "password"    => ENV["THE_GAME_CRAFTER_PASSWORD"],
      "username"    => ENV["THE_GAME_CRAFTER_USERNAME"]
    }
  ).body
)["result"]["id"]

def request(params)
  params[:query] ||= {}
  params[:query].merge!("session_id" => @session_id)
  @conn.request(params)
end

# FIXME: needs to use multipart/mixed :(
def upload_file(path)
  File.open(path, 'r') do |file|
    JSON.parse(
      request(
        :method => :post,
        :query  => {
          :folder_id  => @isru_folder_id,
          :name       => File.basename(file.path)
        }
      ).body
    )["result"]["id"]
  end
end

# lookup and delete existing folder
old_folder_id = JSON.parse(
  request(
    :method => :get,
    :path   => "/api/user/#{GEEMUS_ID}/folders"
  ).body
)["result"]["items"].detect {|item| item["name"] == "ISRU"}["id"]
request(
  :method => :delete,
  :path   => "/api/folder/#{old_folder_id}"
)
@isru_folder_id = JSON.parse(
  request(
    :method => :post,
    :path   => "/api/folder",
    :query  => {
      :name       => "ISRU",
      :parent_id  => ROOT_FOLDER_ID,
      :user_id    => GEEMUS_ID
    }
  ).body
)["result"]["id"]

# FIXME: upload contract back
@isru_contract_back_id = upload_file("./assets/contracts/Contracts.png")
puts @isru_contract_back_id

exit

# lookup and delete existing poker deck(s)
JSON.parse(
  request(
    :method => :get,
    :path   => "/api/game/#{ISRU_ID}/pokerdecks"
  ).body
)["result"]["items"].each do |item|
  request(
    :method => :delete,
    :path => "/api/pokerdeck/#{item["id"]}"
  ).body
end

# create a new poker deck
request(
  :method => :post,
  :path   => "/api/pokerdeck",
  :query  => {
    # FIXME: "back_id"   => "",
    "game_id"   => ISRU_ID,
    # FIXME: "has_proofed_back => "",
    "name"      => "contracts",
    "quantity"  => 1,
  }
)

# FIXME: upload/create contract cards

# FIXME: delete actions/locations
# FIXME: upload actions/locations

# FIXME: delete rules
# FIXME: upload rules

