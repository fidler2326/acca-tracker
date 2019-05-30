module AccasHelper
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
