#require "slack_api_wrapper"
#require "channel"



class HomepagesController < ApplicationController
  def index
    @channels = Slack_Api_Wrapper.listChannels

  end

  def create
    it_worked = Slack_Api_Wrapper.sendMessage(params[:channel], params[:message])
    if it_worked
      redirect_to root_path
    end

  end

  def new
    @channel_id = params[:channel]

    @single_channel = Slack_Api_Wrapper.getChannel(@channel_id)
    # raise
    # Chris's way:
    # @channel = Slack_Api_Wrapper.getChannel(params[:channel])

  end
end
