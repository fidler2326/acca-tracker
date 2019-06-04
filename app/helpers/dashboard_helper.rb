module DashboardHelper
  def get_day_returns date, category
    total_return = Acca.where("date <= ? AND category = ?", date, category).sum(&:return).to_f
    total_stake = Acca.where("date <= ? AND category = ?", date, category).sum(&:stake).to_f
    return (total_return - total_stake).round(2)
  end
end
