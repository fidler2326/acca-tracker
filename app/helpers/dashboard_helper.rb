module DashboardHelper
  def get_day_returns date, category
    week_return = Acca.where("date >= ? AND category = ?", Date.today - 7.days, category).sum(&:return).to_f
    satkes_until_now = Acca.where("date <= ? AND category = ?", date, category).sum(&:stake).to_f
    return week_return - satkes_until_now
  end
end
