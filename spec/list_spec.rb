require("spec_helper")

describe(List) do
  describe("#tasks") do
    it("tells which tasks are in it") do
      test_list = List.create({:name => "list"})
      test_task1 = Task.create({:description => "task1", :list_id => test_list.id})
      test_task2 = Task.create({:description => "task2", :list_id => test_list.id})
     expect(test_list.tasks()).to(eq([test_task1, test_task2]))
    end
  end
    it("valicates presence of description")do
      list = List.new({:name => ""})
      expect(list.save()).to(eq(false))
    end
    it('converts the name to lowercase') do
      list = List.create({:name=> "FINAGLE THE ZEBRA"})
      expect(list.name()).to(eq("finagle the zebra"))
    end

    it("ensures length of description is at least 50 characters")do
      list= List.new({:name => "a".*(51)})
      expect(list.save()).to(eq(false))
    end
  end
