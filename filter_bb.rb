#!/usr/bin/env ruby

require 'csv'

abort <<-MSG unless ARGV[0] =~ /^[-\d.,]+$/
Usage: ruby filter_bb.rb leftlon,bottomlat,rightlon,toplat file.csv
e.g. ruby filter_bb.rb -74.2590899,40.477399,-73.7001714,40.917577 checkins.csv > checkins_nyc.csv
MSG

llon, blat, rlon, tlat = ARGV.shift.split(',').map(&:to_f)

CSV.foreach(ARGV.shift) do |row|
  user, tstamp, lat, lon, id = row
  lat, lon = [lat.to_f, lon.to_f]
  puts row.join(',') if blat < lat && lat < tlat && llon < lon && lon < rlon # this is too naive on new zealand but fine everywhere else
end
