class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  require 'nest_api'
  require 'awesome_print' # gem install awesome_print
  require 'forecast_io'

  # GET /records
  # GET /records.json
  def index
    @records = Record.where(device_id: params[:device_id])

    @data = [
      {name: "Internal Temperature", data: @records.group(:created_at).maximum(:internal_temp)},
      {name: "External Temperature", data: @records.group(:created_at).maximum(:external_temp)},
      {name: "Humidity", data: @records.group(:created_at).maximum(:humidity)}
    ]

  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  def discover_thermostats
    nest = NestApi::Api.new
    nest.get_thermostat_list.last

    device =  nest.get_thermostat_list.first[1]
  end

  # GET /records/new
  def new
    @record = Record.new

    respond_to do |format|
      if @record.save
        format.html { redirect_to(records_path)}
      end
    end

    #@record.save!
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Record was successfully created.' }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:internal_temp, :external_temp, :nest_temp, :nest_temp_high, :nest_temp_low)
    end
end
