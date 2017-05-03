class List
  attr_reader(:name, :id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def self.all
    all_lists = DB.exec("SELECT * FROM lists;")
    saved_lists = []
    all_lists.each() do |list|
      name = list.fetch('name')
      id = list.fetch('id').to_i()
      each_list = List.new({:name => name, :id => id})
      saved_lists.push(each_list)
    end
    saved_lists
  end


  def save
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end



  def ==(another_list)
    self.name() == another_list.name()
  end


  def self.find(id)
    found_list = nil
    List.all().each() do |list|
      if list.id() == id
        found_list = list
      end
    end
    found_list
  end

  define_method(:tasks) do
    list_tasks = []
    tasks = DB.exec("SELECT * FROM tasks WHERE list_id = #{self.id()};")
    tasks.each() do |task|
      description = task.fetch("description")
      list_id = task.fetch("list_id").to_i()
      list_tasks.push(Task.new({:description => description, :list_id => list_id}))
    end
    list_tasks
  end

  def update(attributes)
    @name = attributes[:name]
    @id = self.id()
    DB.exec("UPDATE lists SET name = '#{@name}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM lists WHERE id = #{self.id()};")
    DB.exec("DELETE FROM tasks WHERE list_id = #{self.id()};")
  end

end
