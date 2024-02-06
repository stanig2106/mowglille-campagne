module ApplicationHelper
  def self.day_of_week_fr(date)
    case date.strftime("%u").to_i
    when 1 then "Lun"
    when 2 then "Mar"
    when 3 then "Mer"
    when 4 then "Jeu"
    when 5 then "Ven"
    when 6 then "Sam"
    when 7 then "Dim"
    else "???"
    end
  end
end
