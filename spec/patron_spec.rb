require('spec_helper')

describe(Patron) do

  describe('#name') do
    it('returns the name of the patron') do
      test_patron = Patron.new({:name => "John", :id => nil})
      expect(test_patron.name()).to(eq("John"))
    end
  end

  describe('#id') do
    it('returns the id of the patron') do
      test_patron = Patron.new({:name => "Mike", :id => nil})
      expect(test_patron.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe ('.all_patrons') do
    it('will return empty at first') do
      expect(Patron.all_patrons()).to(eq([]))
    end
  end

  describe('.find') do
    it('return a patron by its id number') do
      test_patron = Patron.new({:name => "Jon Snow", :id => nil})
      test_patron.save()
      test_patron2 = Patron.new({:name => "Forrest Gump", :id => nil})
      test_patron2.save()
      expect(Patron.find(test_patron2.id())).to(eq(test_patron2))
    end
  end

  describe('#save') do
    it('saves a patron to the patrons table') do
      test_patron = Patron.new({:name => "Frodo Baggins", :id => nil})
      test_patron.save()
      expect(Patron.all_patrons()).to(eq([test_patron]))
    end
  end

  describe('#==') do
    it('is the same patron if it has the same name and id') do
      test_patron = Patron.new({:name => "Ender Wiggin", :id => nil})
      test_patron2 = Patron.new({:name => "Ender Wiggin", :id => nil})
      expect(test_patron).to(eq(test_patron2))
    end
  end

  describe('#update') do
    it('lets you update patrons in the database') do
      test_patron = Patron.new({:name => 'Ron Weasley', :id => nil})
      test_patron.save()
      test_patron.update({:name => 'Hermoine Granger'})
      expect(test_patron.name()).to(eq('Hermoine Granger'))
    end
  end

  describe('#delete') do
    it('lets you delete a patron from the database') do
      test_patron = Patron.new({:name => 'Jon Galt', :id => nil})
      test_patron.save()
      test_patron2 = Patron.new({:name => 'Jon Galt', :id => nil})
      test_patron2.save()
      test_patron.delete()
      expect(Patron.all_patrons()).to(eq([test_patron2]))
    end
  end



end
