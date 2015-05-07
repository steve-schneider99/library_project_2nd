class Patron
attr_reader(:name, :id)


  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id).to_i
  end

  define_singleton_method(:all_patrons) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      name = patron.fetch("name")
      id = patron.fetch("id")
      patrons.push(Patron.new({:name => name, :id => id}))
    end
    patrons
  end

  define_singleton_method(:find) do |id|
    @id = id
    returned_patrons = DB.exec("SELECT * FROM patrons WHERE id = '#{@id}';")
    @name = returned_patrons.first.fetch('name')
    Patron.new({:name => @name, :id => @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_method(:==) do |another_patron|
    self.name().==(another_patron.name()).&(self.id().==(another_patron.id()))
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @id = self.id()
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end
end
