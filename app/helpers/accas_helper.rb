module AccasHelper
  def get_bet_type bet_type
    case bet_type
    when "doubles"
        return Acca::Type::DOUBLE
    when "trebles"
        return Acca::Type::TREBLE
    when "4 folds"
        return Acca::Type::FOUR_FOLD
    when "5 folds"
        return Acca::Type::FIVE_FOLD
      when "6 folds"
        return Acca::Type::SIX_FOLD
      when "7 folds"
        return Acca::Type::SEVEN_FOLD
      when "8 folds"
        return Acca::Type::EIGHT_FOLD
    else
      return Acca::Type::SINGLE
    end
  end

  def get_leg_type leg_type
    case leg_type
      when "full time result", "fulltime result"
        return Leg::Type::WIN
      when "draw"
        return Leg::Type::DRAW
      when "double chance"
        return Leg::Type::DOUBLE_CHANCE
      when "draw no bet"
        return Leg::Type::DRAW_NO_BET
      when "both teams to score"
        return Leg::Type::BTTS
      when "alternative total goals", "total goals"
        return Leg::Type::TOTAL_GOALS
      when "alternative corners"
        return Leg::Type::TOTAL_CORNERS
      when "result/both teams to score"
        return Leg::Type::WIN_AND_BTTS
      when "to qualify"
        return Leg::Type::TO_QUALIFY
    else
      return leg_type
    end
  end

  def get_acca_selections acca
    selections = acca.legs.map(&:selection)
    return Selection.find(selections).map(&:name).join(", ") rescue nil
  end

  def leg_class leg
    case true
    when leg.won
      return "won"
    when leg.placed
      return "placed"
    when leg.lost
      return "lost"
    when leg.void
      return "void"
    else
      return "void"
    end
  end

end
