#!/usr/bin/env ruby

require 'dotenv'
require 'restclient'

administration, *other_args = ARGV

Dotenv.load(".env", ".#{administration}.env")

target_file = other_args.join " "
file_name = File.basename(target_file)
puts "Adding #{target_file} to administratie #{ENV['MONEYBIRD_ADMINISTRATION']}"

data = {:typeless_document=>{:reference=>"Scan 2 Moneybird"}}


response = RestClient.post "https://moneybird.com/api/v2/#{ENV['MONEYBIRD_ADMINISTRATION']}/documents/typeless_documents.json", data, { authorization: "Bearer #{ENV['MONEYBIRD_TOKEN']}", content_type: :json, accept: :json }
document = JSON.parse(response)

data = { file: File.new(target_file, "rb") }
response = RestClient.post "https://moneybird.com/api/v2/#{ENV['MONEYBIRD_ADMINISTRATION']}/documents/typeless_documents/#{document['id']}/attachments.json", data, { authorization: "Bearer #{ENV['MONEYBIRD_TOKEN']}", content_type: :json, accept: :json }

if(response.code >= 200 && response.code < 300)
  mv_to_path = "#{ENV['FINISHED_PATH']}/#{file_name}"
  puts "OK. Moving file to: #{mv_to_path}"
  File.rename target_file, mv_to_path
end
