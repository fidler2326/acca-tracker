class Acca < ActiveRecord::Base
  belongs_to :user

  has_many :legs, inverse_of: :acca
  accepts_nested_attributes_for :legs, reject_if: :all_blank, allow_destroy: true

  module Category
    FOOTBALL     = "Football"
    HORSE_RACING = "Horse Racing"
  end
  CATEGORIES = Category.constants.collect {|c| Category.const_get c }

  module Type
    SINGLE    = "Single"
    DOUBLE    = "Double"
    TREBLE    = "Treble"
    FOUR_FOLD = "4 Fold"
    FIVE_FOLD = "5 Fold"
    SIX_FOLD  = "6 Fold"
    LUCKY_31  = "Lucky 31"
    LUCKY_15  = "Lucky 15"
    LUCKY_63  = "Lucky 63"
  end
  BET_TYPES = Type.constants.collect {|c| Type.const_get c }
end