class Selection < ActiveRecord::Base
  module Category
    FOOTBALL     = "Football"
    HORSE_RACING = "Horse Racing"
  end
  CATEGORIES = Category.constants.collect {|c| Category.const_get c }
end