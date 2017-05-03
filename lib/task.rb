class Task
  attr_reader(:description, :list_id)

  def initialize(attributes)
    @description = attributes.fetch(:description);
    @list_id = attributes.fetch(:list_id)
  end

  def self.all
    all_tasks = DB.exec("SELECT * FROM tasks;")
    saved_tasks = []
    all_tasks.each() do |task|
      description = task.fetch('description')
      list_id = task.fetch('list_id').to_i()
      each_task = Task.new({:description => description, :list_id => list_id})
      saved_tasks.push(each_task)
    end
    saved_tasks
  end

  def ==(another_task)
    (self.description() == another_task.description()) && (self.list_id() == another_task.list_id())
  end

  def save
    DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id});")
  end

  

end
