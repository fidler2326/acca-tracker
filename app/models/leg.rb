class Leg < ActiveRecord::Base
  belongs_to :acca

  module Type
    WIN           = "Win"
    EW            = "E/W"
    DOUBLE_CHANCE = "Double Chance"
    DRAW_NO_BET   = "Draw No Bet"
    BTTS          = "Both Teams To Score"
    OVER_0_GOALS  = "Over 0.5 Goals"
    OVER_1_GOALS  = "Over 1.5 Goals"
    OVER_2_GOALS  = "Over 2.5 Goals"
    UNDER_0_GOALS = "Under 0.5 Goals"
    UNDER_1_GOALS = "Under 1.5 Goals"
    UNDER_2_GOALS = "Under 2.5 Goals"
  end
  BET_TYPES = Type.constants.collect {|c| Type.const_get c }

  module Course
    ASCOT = "Ascot"
    EPSOM = "Epsom"
  end
  COURSES = Course.constants.collect {|c| Course.const_get c }
end