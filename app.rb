require('sinatra')
require('sinatra/reloader')
require('sinatra/activerecord')
also_reload('lib/**/*.rb')
require('./lib/task')
require('./lib/list')
require('pry')
require("pg")


get("/") do
  erb(:index)
end

get('/lists/new') do
  @lists = List.all()
  erb(:lists)
end

post('/lists') do
  name = params.fetch('name')
  @list = List.new({:name => name})
  if @list.save()
  erb(:success)
else
  erb(:errors)
end
end

get('/lists/:id/edit') do
  @list = List.find(params.fetch("id").to_i())
  @tasks = @list.tasks()
  erb(:list)
end


#BELOW WAS A MAJOR HEADACHE
post('/tasks/:id') do
  id = params.fetch('id')
  @list = List.find(id)
  description = params.fetch("description")
  @list.tasks().new({:description => description})
   if @list.save()
     @tasks = Task.all()
  erb(:success)
else
  erb(:errors)
  end
end

#ABOVE WAS A MAJOR HEADACH
get('/tasks/:id/edit') do
  @task = Task.find(params.fetch('id').to_i())
  erb(:task_edit)
end

patch("/tasks/:id") do
  description = params.fetch("description")
  @task = Task.find(params.fetch("id").to_i())
  @task.update({:description => description})
  @tasks = Task.all()
  erb(:index)
end
