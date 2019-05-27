class Acca < ActiveRecord::Base
  belongs_to :user

  has_many :legs, inverse_of: :acca
  accepts_nested_attributes_for :legs, reject_if: :all_blank, allow_destroy: true

  module Category
    FOOTBALL     = "FOOTBALL"
    HORSE_RACING = "HORSE RACING"
  end
  CATEGORIES = Category.constants.collect {|c| Category.const_get c }

  module Type
    SINGLE    = "SINGLE"
    DOUBLE    = "DOUBLE"
    TREBLE    = "TREBLE"
    FOUR_FOLD = "4 FOLD"
    FIVE_FOLD = "5 FOLD"
    SIX_FOLD  = "6 FOLD"
    LUCKY_31  = "LUCKY 31"
    LUCKY_15  = "LUCKY 15"
    LUCKY_63  = "LUCKY 63"
  end
  BET_TYPES = Type.constants.collect {|c| Type.const_get c }
end