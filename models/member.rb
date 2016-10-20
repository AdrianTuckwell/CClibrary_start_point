require_relative('../db/sql_runner')

class Member

  attr_reader :id, :name, :address

  def initialize( options )
    @id = options['id'].to_i
    @name = options['name']
    @address = options['address']
  end

  def save()
    sql = "INSERT INTO members (name, address) VALUES ('#{@name}', '#{@address}' ) RETURNING *"
    member = SqlRunner.run(sql).first
    @id = member['id'].to_i
  end

  def books()
    sql = "SELECT books.* FROM books INNER JOIN rentals ON rentals.book_id = books.id WHERE rentals.member_id = #{@id};"
    return Book.map_items(sql)
  end


  def self.all()
    sql = "SELECT * FROM members"
    return Member.map_items(sql)
  end

  def self.find(id)
    sql = "SELECT * FROM members WHERE id = #{id}"
    return Member.map_item(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM members"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    members = SqlRunner.run(sql)
    result = members.map { |member| Member.new( member ) }
    return result
  end

  def self.map_item(sql)
    result = Member.map_items(sql)
    return result.first
  end

end
