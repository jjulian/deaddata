require 'json'
require 'date'
require 'hashie'

class Setlists
  attr :hashie
  def initialize
    # https://github.com/MichaelAdamBerry/darkstar-project/tree/master/data
    @hashie = Hashie::Mash.new JSON.parse(File.read('./data/gratefulSetlist.json'))
  end

  def each
    @hashie.setlists.each do |show|
      yield show
    end
  end
end
