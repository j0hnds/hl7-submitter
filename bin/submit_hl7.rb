#!/usr/bin/env ruby
#
# This client uses SAVON to invoke the HL7 service on the
# Mirth server.

# Provides the SAVON client. This allows us to easily send messages
# to the Mirth SOAP service.
require 'savon'
# To encode the HL7 data to be consumed by the Mirth service
require 'base64'
# For command line parsing
# require 'optparse'
require 'hl7-submitter'

#options = {
  #host: 'localhost',
  #port: 20440,
  #auth: false,
  #username: 'pcc',
  #password: 'Splatter',
  #verbose: false,
  #run: true
#}

#OptionParser.new do | opts |
  #opts.banner = 'Usage: submit_hl7.rb [options]'

  #opts.on('-a', '--auth', "Use basic auth; must specify username and password. Defaults to false") do 
    #options[:auth] = true
  #end

  #opts.on('-h', '--host HOST', "Specify the web service host. Defaults to '#{options[:host]}'") do | host |
    #options[:host] = host
  #end

  #opts.on('-f', '--file PATH', "Specify the file containing the HL7 data to submit") do | path |
    #options[:file] = path
  #end

  #opts.on('-n', '--no-run', "Don't actually run the service") do 
    #options[:run] = false
  #end

  #opts.on('-p', '--port PORT', Integer, "Specify the port of the web service host. Defaults to '#{options[:port]}'") do | port |
    #options[:port] = port
  #end

  #opts.on('-u', '--username USERNAME', "Specify the username for authentication.") do | username |
    #options[:username] = username
  #end

  #opts.on('-v', '--verbose', "Display verbose") do
    #options[:verbose] = true
  #end

  #opts.on('--password PASSWORD', "Specify the password for authentication.") do | password |
    #options[:password] = password
  #end

  #opts.on('--help', "Show the help for this script") do
    #puts opts
    #exit
  #end

#end.parse!

options = CmdlineOptions.new.tap { | clo | clo.parse! }

if options.verbose?
# if options[:verbose]
  puts "Options specified: #{options.inspect}"
end

hl7_data = options.hl7_data
#if options[:file]
  #hl7_data = File.read(options[:file])
#else
  ## The HL7 message to send
  #hl7_data = 'MSH|^~\&|PCC|2008|fart|GRAP|20140709000000||ADT^A03|154383|T|2.5
#EVN|A03|20140709000000|||grap|19570711000000
#PID|1||121212121^^^^FI~130104^6102^^^HC~130104^^^^PN~121212121^^^^SS||Brooks^susie||19570711000000|F||||||||||130104|121212121
#PV1|1|I|^^^^^N^19|||||||||||||||2||||||||||||||||||||||||||20140421000000|20140708000000'
#end

if options.verbose?
  puts "The HL7 data being sent:"
  puts hl7_data
end

# Build a client against the WSDL of the Mirth SOAP service
#
# wsdl: The URL to the Mirth service WSDL. The host:port must match the
#       host:port of the source connector you want to communicate with.
#
# basic_auth: The username and password to the service. Without this, you
#             wouldn't be able to connect to the Mirth service at all
#             (e.g. basic_auth: [ 'user', 'password' ]).
#
#             PCC doesn't want to deal with this, so we'll have to remove
#             this bit from the setup. This means we'll have to remove the
#             credentials from the source connector
#
client_options = {
  wsdl: "http://#{options.host}:#{options.port}/services/Mirth?wsdl"
}

if options.basic_auth?
  client_options[:basic_auth] = [ options.username, options.password ]
end

client = Savon.client(client_options)

# Just debugging; it will list out the operations present for this service.
if options.verbose?
  puts "The available operations: #{client.operations.inspect}"
end

if options.run?
  # Invoke the service:
  # 
  # Note that the following reflects the custom Mirth connector
  # we're using just for PCC. The message provides the following
  # arguments:
  #
  #   username: the user for the service
  #   password: the password for the service
  #   data: the actual uuencoded payload of the service.
  #
  response = client.call(
    :submit_message, 
    message: { 
      username: options.username,
      password: options.password,
      data: Base64.encode64(hl7_data)
    }
  )

  # Dump the response from the server
  puts "Here's what we got: #{response.body}"
  puts "Here's what we got: #{response.to_xml}"
end
