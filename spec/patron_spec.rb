require('spec_helper')

describe(Patron) do

  describe('#initialize') do
    it("will create an instance of a patron") do
      patron = Patron.new({:name => "Z Perez", :id => nil})
      expect(patron.name).to(eq("Z Perez"))
    end
  end

  describe('.all') do
    it("will return a list of patrons") do
      expect(Patron.all).to_eq([])
    end
  end

  describe('#save') do
    it("saves a patron") do
      patron = Patron.new({:name => "Z Perez", :id => nil})
      patron.save()
      patron2 = Patron.new({:name => "Greg G", :id => nil})
      patron2.save()
      expect(Patron.all).to(eq([patron, patron2]))
    end
  end

  describe('#update') do
    it("will update patron information") do
      patron = Patron.new({:name => "Z Perez", :id => nil})
      patron.save()
      patron.update({:name => "Zzz Perez"})
      patron.save()
      expect(patron.name).to(eq("Zzz Perez"))
    end
  end

  describe('#==') do
    it("is the same patron if it has the same attributes as another patron") do
      patron = Patron.new({:name => "Z Perez", :id => nil})
      patron2 = Patron.new({:name => "Z Perez", :id => nil})
      expect(patron).to(eq(patron2))
    end
  end

  describe('.find') do
    it("find a patron by id") do
      patron = Patron.new(:name => "Z Perez", :id => nil)
      patron.save()
      patron2 = Patron.new(:name => "Greg G", :id => nil)
      patron2.save()
      expect(Patron.find(patron.id)).to(eq(patron))
    end
  end

  describe('.clear') do
    it("clears all patrons") do
      patron = Patron.new({:name = "Z Perez", :id => nil})
      patron.save()
      patron2 = Patron.new({:name = "Greg G", :id => nil})
      patron2.save()
      Patron.clear()
      expect(Patron.all).to(eq([]))
    end
  end
end

# one missing test???