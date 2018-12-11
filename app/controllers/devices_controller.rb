class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all


    @devices.first.create_new_record
  end

  def refresh

    nest = NestApi::Api.new

    @remotedevices   =  nest.get_thermostat_list

    @remotedevices.each do |device|
      ap device
      data = device[1]
      device_name = data.get('device_id')
      puts device_name
      #ap Device.where(device_id: device_name)
      #unless Device.where(device_id: device_name).count > 0
      new_device = Device.create(device_id: data.get("device_id"),name: data.get("name"),
                                 name_long: data.get("name_long"),
                                 can_heat: data.get("can_heat"),
                                 can_cool: data.get("can_cool"))
      #end
    end

    redirect_to devices_path
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to @device, notice: 'Device was successfully created.' }
        format.json { render :show, status: :created, location: @device }
      else
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to @device, notice: 'Device was successfully updated.' }
        format.json { render :show, status: :ok, location: @device }
      else
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:device_id, :name, :name_long, :is_online, :can_cool, :can_heat, :last_connection)
    end
end
