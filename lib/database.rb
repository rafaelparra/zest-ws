require 'singleton'
require 'mysql2'
require 'ostruct'

class Database
  include Singleton

  def initialize
    client 
  end

  def client
    @client ||= Mysql2::Client.new( host: 'localhost', username: "root", database: 'water_sample', :reconnect => true )
  end

end