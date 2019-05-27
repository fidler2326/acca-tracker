class Selection < ActiveRecord::Base
  module Category
    FOOTBALL     = "FOOTBALL"
    HORSE_RACING = "HORSE RACING"
  end
  CATEGORIES = Category.constants.collect {|c| Category.const_get c }
end