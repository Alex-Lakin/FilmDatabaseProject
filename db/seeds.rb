require_relative("../models/film")
require_relative("../models/director")
require_relative("../models/film_director")

jphash = {"title" => "Jurassic Park",
  "year" => "1993",
  "rating" => "5"}
jp = Film.new(jphash)
jp.save()

sphash = {"name" => "Steven Speilberg"}
sp = Director.new(sphash)
sp.save()

cstng = Film_Director.new({"film_id" => jp.id,"director_id" => sp.id})
cstng.save()
