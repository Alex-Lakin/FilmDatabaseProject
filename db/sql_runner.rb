require("pg")

class SqlRunner

  def self.run(sql,values = [])
    begin
      db = PG.connect({dbname: "filmprojectdatabase", host: "localhost"})
      db.prepare("q", sql)
      result = db.exec_prepared("q", values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
