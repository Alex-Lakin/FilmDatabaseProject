require("pg")

class SqlRunner

  def self.run(sql,values = [])
    begin
      db = PG.connect({dbname: "dmobajmqi5o12", host: "ec2-54-225-200-15.compute-1.amazonaws.com"
        port: 5432, user: 'ktuaknnhdgrets', password: '58df176540e6f1bb0fb551b55ba6983e5d68944d8095977b799ceea028a8061d'})
      db.prepare("q", sql)
      result = db.exec_prepared("q", values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
