require 'optparse'

class CmdlineOptions
  attr_reader :options

  DEFAULT_HOST = 'localhost'
  DEFAULT_PORT = 20440
  DEFAULT_BASIC_AUTH = false
  DEFAULT_USERNAME = 'pcc'
  DEFAULT_PASSWORD = 'Splatter'
  DEFAULT_VERBOSE = false
  DEFAULT_RUN = true

  def initialize
    @options = {
      host: DEFAULT_HOST,
      port: DEFAULT_PORT,
      auth: DEFAULT_BASIC_AUTH,
      username: DEFAULT_USERNAME,
      password: DEFAULT_PASSWORD,
      verbose: DEFAULT_VERBOSE,
      run: DEFAULT_RUN
    }

    @option_parser = OptionParser.new do | opts |
      opts.banner = 'Usage: submit_hl7.rb [options]'

      opts.on('-a', '--auth', "Use basic auth; must specify username and password. Defaults to false") do 
        @options[:auth] = true
      end

      opts.on('-h', '--host HOST', "Specify the web service host. Defaults to '#{@options[:host]}'") do | host |
        @options[:host] = host
      end

      opts.on('-f', '--file PATH', "Specify the file containing the HL7 data to submit") do | path |
        @options[:file] = path
      end

      opts.on('-n', '--no-run', "Don't actually run the service") do 
        @options[:run] = false
      end

      opts.on('-p', '--port PORT', Integer, "Specify the port of the web service host. Defaults to '#{@options[:port]}'") do | port |
        @options[:port] = port
      end

      opts.on('-u', '--username USERNAME', "Specify the username for authentication.") do | username |
        @options[:username] = username
      end

      opts.on('-v', '--verbose', "Display verbose") do
        @options[:verbose] = true
      end

      opts.on('--password PASSWORD', "Specify the password for authentication.") do | password |
        @options[:password] = password
      end

      opts.on('--help', "Show the help for this script") do
        puts opts
        exit
      end

    end
  end

  def parse!
    @option_parser.parse!
  end

  def verbose?
    options[:verbose]
  end

  def basic_auth?
    options[:auth]
  end

  def run?
    options[:run]
  end

  def host
    options[:host]
  end

  def port
    options[:port]
  end

  def username
    options[:username]
  end

  def password
    options[:password]
  end

  def hl7_data
    if options[:file]
      hl7_data = File.read(options[:file])
    else
      # The HL7 message to send
      hl7_data = 'MSH|^~\&|PCC|2008|fart|GRAP|20140709000000||ADT^A03|154383|T|2.5
    EVN|A03|20140709000000|||grap|19570711000000
    PID|1||121212121^^^^FI~130104^6102^^^HC~130104^^^^PN~121212121^^^^SS||Brooks^susie||19570711000000|F||||||||||130104|121212121
    PV1|1|I|^^^^^N^19|||||||||||||||2||||||||||||||||||||||||||20140421000000|20140708000000'
    end
  end

end
