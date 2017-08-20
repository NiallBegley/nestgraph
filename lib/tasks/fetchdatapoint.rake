namespace :nestgraphing do
  task fetchdata: :environment do
    Device.all.each do |device|
      puts "Creating record for " + device.name

      device.create_new_record
    end
  end

  task providecredentials: :environment do

    puts "Please generate a pin code at #{NestApi::AUTH_URL}#{ENV.fetch("NEST_PRODUCT_ID")} and enter it here:"
    pin = STDIN.gets.strip

    result = HTTParty.post("#{NestApi::TOKEN_URL}", query: {
        code: pin,
        client_id: ENV['NEST_PRODUCT_ID'],
        client_secret: ENV['NEST_PRODUCT_SECRET'],
        grant_type: 'authorization_code'
    })


    puts "Place this code in your NEST_API_AUTH_TOKEN env variable and restart server:\n" + result["access_token"]

  end

  task deleteoldrecords: :environment do
    Record.where("created_at <= ?", Time.zone.now - 7.days).destroy_all
  end

  end