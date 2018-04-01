require_relative("../models/film")
require_relative("../models/director")
require_relative("../models/film_director")

# jphash = {"title" => "Jurassic Park",
#   "year" => "1993",
#   "rating" => "5"}
# jp = Film.new(jphash)
# jp.save()
#
# lwhash = {"title" => "The Lost World: Jurassic Park",
#   "year" => "1997",
#   "rating" => "3"}
# lw = Film.new(lwhash)
# lw.save()
#
# j3hash = {"title" => "Jurassic Park III",
#   "year" => "2001",
#   "rating" => "3"}
# j3 = Film.new(j3hash)
# j3.save()
#
# sphash = {"name" => "Steven Speilberg"}
# sp = Director.new(sphash)
# sp.save()
#
# jjhash = {"name" => "Joe Johnston"}
# jj = Director.new(jjhash)
# jj.save()
#
# jpcstng = Film_Director.new({"film_id" => jp.id,"director_id" => sp.id})
# jpcstng.save()
#
# lwcstng = Film_Director.new({"film_id" => lw.id,"director_id" => sp.id})
# lwcstng.save()
#
# j3cstng = Film_Director.new({"film_id" => j3.id,"director_id" => jj.id})
# j3cstng.save()
