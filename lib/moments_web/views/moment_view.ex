defmodule MomentsWeb.MomentView do
  use MomentsWeb, :view

  def view_date(naive_date_time) do
    {{year, month, day}, _} = NaiveDateTime.to_erl(naive_date_time)
    "#{year}.#{month}.#{day}"
  end

  def view_entry(moment) do
    raw(moment.entry)
  end
end
