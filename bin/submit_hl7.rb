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
require 'hl7-submitter'

options = CmdlineOptions.new.tap { | clo | clo.parse! }

if options.verbose?
  puts "Options specified: #{options.inspect}"
end

hl7_data = options.hl7_data

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

  {:submit_message_response=>{:data=>"TVNIfF5+XCZ8YWJhcWlzTWlydGh8MjAwOHxmYXJ0fEdSQVB8MjAxNDA3MDk
                              wMDAwMDB8fEFDS3wxNTQzODN8UHwyLjUKTVNBfEFBfDE1NDM4Mw==", :"@xmlns:ns2"=>"http://www.pointclickcare.com/msg/"}}
  # Dump the response from the server
  puts "Here's what we got (as Hash): \n#{response.body}"
  puts
  puts "Here's what we got: (as XML): \n#{response.to_xml}"
  puts
  puts "Here's the decoded response: \n#{Base64.decode64(response.body[:submit_message_response][:data])}"
end
