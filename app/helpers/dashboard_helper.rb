module DashboardHelper
  def get_day_returns date, category
    total_return = Acca.where("date <= ? AND category = ?", date, category).sum(&:return).to_f rescue 0
    total_stake = Acca.where("date <= ? AND category = ?", date, category).sum(&:stake).to_f rescue 0
    return (total_return - total_stake).round(2)
  end

  def profit_loss date
    total_return = Acca.where("date >= ?", date).sum(&:return).to_f rescue 0
    total_stake = Acca.where("date >= ?", date).sum(&:stake).to_f rescue 0
    return (total_return - total_stake).round(2)
  end

  def total_staked date
    return total_stake = Acca.where("date >= ?", date).sum(&:stake).to_f.round(2) rescue 0
  end

  def total_bets date
    return Acca.where("date >= ?", date).count rescue 0
  end

  def lost_by_one
    Acca.where("date >= ?", date).legs.map(&:lost)
  end
end
