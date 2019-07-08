module DashboardHelper
  def get_day_returns date, category
    total_return = Acca.where(date: Date.today - 7.days..date, category: category).sum(&:return).to_f rescue 0
    total_stake = Acca.where(date: Date.today - 7.days..date, category: category).sum(&:stake).to_f rescue 0
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
    # Acca.where("date >= ?", date).legs.map {|leg| }
  end

  def average_stake
    stakes = Acca.where(date: Date.today - 7.days..Date.today).map{|acca| acca.stake.to_f}
    return (stakes.inject{ |sum, el| sum + el }.to_f / stakes.size).round(2)
  end

  def average_return
    returns = Acca.where(date: Date.today - 7.days..Date.today).map{|acca| acca.return.to_f}
    return (returns.inject{ |sum, el| sum + el }.to_f / returns.size).round(2)
  end

  def largest_stake
    largest_stake = Acca.where(date: Date.today - 7.days..Date.today).map{|acca| acca.stake.to_f}.max
    return largest_stake
  end

  def smallest_stake
    smallest_stake = Acca.where(date: Date.today - 7.days..Date.today).map{|acca| acca.stake.to_f}.min
    return smallest_stake
  end

  def biggest_win
    biggest_win = Acca.where(date: Date.today - 7.days..Date.today).map{|acca| acca.return.to_f}.max
    return biggest_win
  end

  def biggest_loss
    biggest_win = Acca.where(date: Date.today - 7.days..Date.today, return: 0).map{|acca| acca.stake.to_f}.max
    return biggest_win
  end

  def most_backed_teams
    teams = Acca.where(category: Acca::Category::FOOTBALL).map{|a| a.legs}.flatten.group_by(&:selection).map{|k,v| [k, v.length]}.sort_by{|k, v| v}.reverse.take(10) rescue []
    return teams
  end

  def most_winning_teams
    teams = Acca.where(category: Acca::Category::FOOTBALL).map{|a| a.legs.where(won: true)}.flatten.group_by(&:selection).map{|k,v| [k, v.length]}.sort_by{|k, v| v}.reverse.take(10) rescue []
    return teams
  end

  def most_losing_teams
    teams = Acca.where(category: Acca::Category::FOOTBALL).map{|a| a.legs.where(lost: true)}.flatten.group_by(&:selection).map{|k,v| [k, v.length]}.sort_by{|k, v| v}.reverse.take(10) rescue []
    return teams
  end

  def acca_type date
    acca_type = Acca.where(date: date..Date.today).group_by(&:bet_type).map{|k,v| [k, v.length]}.sort_by{|k, v| v}.reverse.take(5) rescue []
    return acca_type
  end

  def bet_type date
    bet_type = Acca.where(date: date..Date.today).map{|a| a.legs}.flatten.group_by(&:leg_type).map{|k,v| [k, v.length]}.sort_by{|k, v| v}.reverse.take(5) rescue []
    return bet_type
  end
end
