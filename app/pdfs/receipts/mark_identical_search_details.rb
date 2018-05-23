private
def mark_identical_search_detail(receipt)

    @receipt = receipt

    formatted_text [{:text => "Objet:", :styles => [:bold, :underline]}, 
      {:text => " Recherche à l'identique de " + @receipt.number_searches.to_s + " Marques"}
    ]

    move_down 20

    # Gathering data table for similar search
    
    data =
      [["Code", "Désignation", "Nombre", "Montant", "Total"],
      ["746-07", "Taxe de Recherche a l'identique par marque", "%02d" % @receipt.number_searches, money_format(@receipt.base_tax), money_format(@receipt.base_tax*@receipt.number_searches)]]
      if @receipt.number_additional_classes.positive?
        data += [["746-07", "Taxe de Recherche a l'identique au delà d'une classe supplémentaire", "%02d" % @receipt.number_additional_classes, money_format(@receipt.class_tax), money_format(@receipt.class_tax*@receipt.number_additional_classes)]]
      end

    # Last line of the table with total
    data += [["","","", "Total", money_format(@receipt.total)]]

    # Drawing mark taxe table
    detail_table_setting(data)
end