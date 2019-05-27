class Leg < ActiveRecord::Base
  belongs_to :acca

  module Type
    WIN           = "WIN"
    EW            = "EW"
    DOUBLE_CHANCE = "DOUBLE_CHANCE"
    DRAW_NO_BET   = "DRAW_NO_BET"
    BTTS          = "BOTH_TEAMS_TO_SCORE"
  end
  BET_TYPES = Type.constants.collect {|c| Type.const_get c }
end