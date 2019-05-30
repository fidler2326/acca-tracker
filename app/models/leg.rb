class Leg < ActiveRecord::Base
  belongs_to :acca

  module Type
    WIN           = "Win"
    EW            = "E/W"
    DOUBLE_CHANCE = "Double Chance"
    DRAW_NO_BET   = "Draw No Bet"
    BTTS          = "Both Teams To Score"
  end
  BET_TYPES = Type.constants.collect {|c| Type.const_get c }
end