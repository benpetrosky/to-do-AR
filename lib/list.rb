class List < ActiveRecord::Base
  has_many(:tasks)
    validates(:name,{:presence => true, :length => {:maximum => 50}})
    before_save(:downcase_name)


    private
    def downcase_name
      self.name=(name().downcase())
    end
end
