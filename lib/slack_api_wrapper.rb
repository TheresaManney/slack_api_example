require 'httparty'

class Slack_Api_Wrapper
  BASE_URL = "https://api.slack.com/api/"
  TOKEN = ENV["SLACK_TOKEN"]

  def self.getChannel(id)
    url = BASE_URL + "channels.info?" + "token=#{TOKEN}&" + "channel=#{id}"
    response = HTTParty.get(url)
    return response.parsed_response
    # Chris's way:
    # return Channel.new(response["channel"]["name"], response["channel"]["id"])
  end

  def self.sendMessage(channel_id, text, token = nil)
    token ||= TOKEN

    url = BASE_URL + "chat.postMessage?" + "token=#{token}&" + "channel=#{channel_id}&" + "text=#{text}"

    response = HTTParty.post(url,
    body: {
      "text" => "#{text}",
      "channel" => "#{channel_id}",
      "username" => "time",
      "icon_emoji" => ":hourglass_flowing_sand:",
      "as_user" => false
    },
      headers: { 'Contact-Type' => 'application/x-www-form-urlencoded'}
    )

    return response["ok"]
  end

  # def self.sendMessage(channel_id, text)
  #   url = BASE_URL + "chat.postMessage?" + "token=#{TOKEN}&" + "channel=#{channel_id}&" + "text=#{text}"
  #
  #   response = HTTParty.get(url)
  #
  #   return response["ok"]
  # end

  def self.listChannels
    url = BASE_URL + "channels.list?" + "token=#{TOKEN}"

    response = HTTParty.get(url)

    channels = []
    response["channels"].each do |channel|
      id = channel["id"]
      name = channel["name"]
      channels << Channel.new(name, id)
    end
    return channels
  end
end
