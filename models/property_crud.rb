require('pg')

class PropertyCrud
  attr_accessor :address, :value, :bedrooms, :build
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value']
    @bedrooms = options['bedrooms']
    @build = options['build']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql =
    "INSERT INTO property_tracker
    (
      address,
      value,
      bedrooms,
      build
    )
    VALUES
    (
      $1,
      $2,
      $3,
      $4
    )
    RETURNING *
    "
    values = [@address, @values, @bedrooms, @build]
    db.prepare("save", sql)

    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def PropertyCrud.all()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql ="SELECT * FROM property_tracker"

    db.prepare("all", sql)
    properties = db.exec_prepared("all")

    db.close()
    return properties.map {|prop| PropertyCrud.new(prop)}
  end



  def update()
    db = PG.connect({dbname: 'property_tracker', host: 'localhost'})

    sql ="UPDATE property_tracker
    SET
    (
      address,
      value,
      bedrooms,
      build
    )=(
      $1, $2, $3, $4
    )
    WHERE id = $5
    "
    values = [@address, @values, @bedrooms, @build, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def delete()
    db = PG.connect(dbname: 'property_tracker', host: 'localhost')

    sql = "DELETE FROM property_tracker WHERE id = $1"

    value = [@id]

    db.prepare("delete", sql)
    db.exec_prepared("delete", value)
    db.close()
  end

  def PropertyCrud.find(id)

    db = PG.connect(dbname: 'property_tracker', host: 'localhost')

    sql = "SELECT * FROM property_tracker WHERE id = $1"
    value = [id]

    db.prepare('find_by_id', sql)
    result = db.exec_prepared('find_by_id', value)
    db.close()

    # return PropertyCrud.new(result)
    return result.map{|res| PropertyCrud.new(res)}
  end

  def PropertyCrud.find_by_address(address)

    db = PG.connect(dbname: 'property_tracker', host: 'localhost')

    sql = "SELECT * FROM property_tracker WHERE address = $1"
    value = [address]

    db.prepare('find_by_address', sql)
    result = db.exec_prepared('find_by_address', value)
    db.close()
    

    res_map = result.map{|res| PropertyCrud.new(res)}

    return res_map[0]


  end









end #class end
