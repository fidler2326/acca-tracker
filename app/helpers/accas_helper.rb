module AccasHelper
  def get_acca_selections acca
    selections = acca.legs.map(&:selection)
    return Selection.find(selections).map(&:name).join(", ") rescue nil
  end
end
