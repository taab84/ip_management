def detail_table_setting(data)
  table(data, :header => true, :position => :right, width: bounds.width, :cell_style => { size: 11 }) do
    last_cell = cells.columns(0..2).rows(-1)
    last_cell.borders = [:top]
    style(row(-1).columns(0..-1), :font_style => :bold)
    style(columns(2), :align => :center, :width => 50)
    style(row(0), :align => :center)
    style(row(1..-2).columns(3..4), :align => :right)
    style(row(-1).columns(-2), :align => :center)
    style(row(-1).columns(-1), :align => :right)
    style(columns(0), :width => 45)
    style(columns(-2..-1), :width => 80)
  end
end