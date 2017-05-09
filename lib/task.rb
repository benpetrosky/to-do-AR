class Task < ActiveRecord::Base
  belongs_to(:list)
  validates(:description,{:presence => true, :length => {:maximum => 50}})
  
  scope(:not_done, -> do
    where({:done => false})
  end)
end
