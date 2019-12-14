module DashboardHelper

  HIDDEN_SELECTIONS = Selection.where(hidden:true).pluck(:id)

  def win_rate accas
    return {
        total_bets: accas.count,
        total_winners: accas.where("return > 0").count,
        win_rate: (accas.where("return > 0").count * 100 / accas.count)
      }
  end

  def selection_win_rate accas, selection
    return {
      total_bets: accas.includes(:legs).where("legs.selection = ?", selection).references(:legs).count,
      total_winners: accas.includes(:legs).where("legs.won = true AND legs.selection = ?", selection).references(:legs).count,
      win_rate: (accas.includes(:legs).where("legs.won = true AND legs.selection = ?", selection).references(:legs).count * 100 / accas.includes(:legs).where("legs.selection = ?", selection).references(:legs).count)
    }
  end

  def lucky_days accas
    accas.all.where("return > 0").map{|a| a.date.strftime("%A")}.inject(Hash.new(0)) {|h,i| h[i] += 1; h }
  end

  def profit_loss_by_date accas
    accas.group_by{|a| a.date.beginning_of_week}.sort.map{|k,v| [k, ((Acca.all.where("date < ?", k).sum(&:return).to_f.round(2) - Acca.all.where("date < ?", k).sum(&:stake).to_f.round(2)) + (v.sum(&:return).to_f.round(2) - v.sum(&:stake).to_f.round(2)))]}
  end

  def profit_loss accas
    total_return = accas.sum(&:return).to_f rescue 0
    total_stake = accas.sum(&:stake).to_f rescue 0
    return (total_return - total_stake).round(2)
  end

  def total_staked accas
    return total_stake = accas.sum(&:stake).to_f.round(2) rescue 0
  end

  def total_bets accas
    return accas.count rescue 0
  end

  def lost_by_one accas
    # Acca.where("date >= ?", date).legs.map {|leg| }
  end

  def average_stake accas
    stakes = accas.map{|acca| acca.stake.to_f}
    return (stakes.inject{ |sum, el| sum + el }.to_f / stakes.size).round(2)
  end

  def average_return accas
    returns = accas.map{|acca| acca.return.to_f}
    return (returns.inject{ |sum, el| sum + el }.to_f / returns.size).round(2)
  end

  def largest_stake accas
    largest_stake = accas.map{|acca| acca.stake.to_f}.max
    return largest_stake
  end

  def smallest_stake accas
    smallest_stake = accas.map{|acca| acca.stake.to_f}.min
    return smallest_stake
  end

  def biggest_win accas
    biggest_win = accas.map{|acca| acca.return.to_f}.max
    return biggest_win
  end

  def biggest_loss accas
    biggest_win = accas.map{|acca| acca.stake.to_f}.max
    return biggest_win
  end

  def most_backed_teams accas
    # TODO - This is shocking D: make it better
    teams = accas.map{|a| a.legs}.flatten.group_by(&:selection).map{|k,v| [k, v.length] unless HIDDEN_SELECTIONS.include?(k)}.compact.sort_by{|k, v| v}.reverse.take(10) rescue []
    return teams
  end

  def most_winning_teams accas
    # TODO - This is shocking D: make it better
    teams = accas.map{|a| a.legs.where(won: true)}.flatten.group_by(&:selection).map{|k,v| [k, v.length] unless HIDDEN_SELECTIONS.include?(k)}.compact.sort_by{|k, v| v}.reverse.take(10) rescue []
    return teams
  end

  def most_losing_teams accas
    # TODO - This is shocking D: make it better
    teams = accas.map{|a| a.legs.where(lost: true)}.flatten.group_by(&:selection).map{|k,v| [k, v.length] unless HIDDEN_SELECTIONS.include?(k)}.compact.sort_by{|k, v| v}.reverse.take(10) rescue []
    return teams
  end

  # def acca_type date
  #   acca_type = Acca.where(date: date..Date.today).group_by(&:bet_type).map{|k,v| [k, v.length]}.sort_by{|k, v| v}.reverse.take(5) rescue []
  #   return acca_type
  # end
  #
  # def bet_type date
  #   bet_type = Acca.where(date: date..Date.today).map{|a| a.legs}.flatten.group_by(&:leg_type).map{|k,v| [k, v.length]}.sort_by{|k, v| v}.reverse.take(5) rescue []
  #   return bet_type
  # end
end
