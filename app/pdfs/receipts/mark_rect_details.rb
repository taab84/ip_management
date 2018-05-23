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
    detail_table_setting(data)
end