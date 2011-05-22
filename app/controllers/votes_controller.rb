class VotesController < ApplicationController
  # GET /votes/1
  # GET /votes/1.xml
  def show
    @vote = Vote.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @vote }
    end
  end

  # POST /votes
  def create
    @vote = Vote.new(params[:vote])

    case params[:direction]
    when 'up'
      @vote.direction = '+'
    when 'down'
      @vote.direction = '-'
    end

    @vote.ip_address = request.env['REMOTE_ADDR']
    @vote.quote_id ||= params[:quote].to_i

    # Delete any previous vote on the same quote, from the same IP
    Vote.destroy_all({:ip_address => @vote.ip_address, :quote_id => @vote.quote_id})

    respond_to do |format|
      if @vote.save
        format.html { redirect_to(vote_path(@vote, :page => params[:page]), :notice => 'Vote was successfully created.') }
      else
        format.html { redirect_to(@vote.quote, :notice => 'There was an error processing your vote. Please try again.') }
      end
    end
  end
end
