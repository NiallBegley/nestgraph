namespace :nestgraphing do
  task fetchdata: :environment do
    Device.all.each do |device|
      puts "Creating record for " + device.name

      device.create_new_record
    end
  end

  task providecredentials: :environment do

    puts "Go:"
    pin = STDIN.gets.strip

    result = HTTParty.post("#{NestApi::TOKEN_URL}", query: {
        code: pin,
        client_id: ENV['NEST_PRODUCT_ID'],
        client_secret: ENV['NEST_PRODUCT_SECRET'],
        grant_type: 'authorization_code'
    })

    puts result
    puts NestApi::CONFIG_FILE

    @auth_code = JSON.parse(File.read(@file))

    puts @auth_code

    File.open(NestApi::CONFIG_FILE, "w") { |file| file.write(result.to_json) }

  end

  task deleteoldrecords: :environment do
    Record.where("created_at <= ?", Time.zone.now - 7.days).destroy_all
  end

  end