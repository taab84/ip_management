private
def mark_rect_detail(receipt)

    @receipt = receipt

    formatted_text [{:text => "Objet:", :styles => [:bold, :underline]}, 
      {:text => " Rectification d'erreur Materiel de " + @receipt.number_marks.to_s + " Marques"}
    ]

    move_down 20

    # Gathering data table for similar search
    
    data =
      [["Code", "Désignation", "Nombre", "Montant", "Total"],
      ["746-09", "Taxe de rectification d'erreur materiel", "%02d" % @receipt.number_marks, money_format(@receipt.tax), money_format(@receipt.tax*@receipt.number_marks)]]

    # Last line of the table with total
    data += [["","","", "Total", money_format(@receipt.total)]]

    # Drawing mark taxe table
    table(data, :header => true, :position => :right, width: bounds.width, :cell_style => { size: 11 }) do
      last_cell = cells.columns(0..2).rows(-1)
      last_cell.borders = [:top]
      style(row(-1).columns(0..-1), :font_style => :bold)
      style(columns(2), :align => :center)
      style(row(0), :align => :center)
      style(row(1..-2).columns(3..4), :align => :right)
      style(row(-1).columns(-2), :align => :center)
      style(row(-1).columns(-1), :align => :right)
    end
end