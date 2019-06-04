module DashboardHelper
  def get_day_returns date, category
    week_return = Acca.where("date >= ? AND category = ?", Date.today - 7.days, category).sum(&:return).to_f
    today_stake = Acca.where(date: date, category: category).sum(&:stake).to_f
    p week_return
    return week_return - today_stake
  end
end
