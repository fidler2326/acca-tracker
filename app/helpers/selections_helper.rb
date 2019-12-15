module SelectionsHelper
  def get_acca_selections acca
    selections = acca.legs.map(&:selection)
    p "HERE123"
    p acca.legs.map{|leg| leg.selection}
    p selections
    return Selection.find(selections).map(&:name).join(", ") rescue nil
  end
end