private
def mark_similar_search_detail(receipt)

    @receipt = receipt

    formatted_text [{:text => "Objet:", :styles => [:bold, :underline]}, 
      {:text => " Recherche de Similitude de " + @receipt.number_searches.to_s + " Marques"}
    ]

    move_down 20

    # Gathering data table for similar search
    
    data =
      [["Code", "Désignation", "Nombre", "Montant", "Total"],
      ["746-08", "Taxe de Recherche de Similitude / ou par déposant dans 3 classes", "%02d" % @receipt.number_searches, money_format(@receipt.base_tax), money_format(@receipt.base_tax*@receipt.number_searches)]]
      if @receipt.number_searches_with_more_than_three_classes.positive?
        data += [["746-08", "Taxe au delà de la 3ème classe/ ou par déposant dans 3 classes", "%02d" % @receipt.number_searches_with_more_than_three_classes, money_format(@receipt.class_tax), money_format(@receipt.class_tax*@receipt.number_searches_with_more_than_three_classes)]]
      end

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