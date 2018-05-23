private
def design_detail(receipt)

    @receipt = receipt

    formatted_text [{:text => "Objet:", :styles => [:bold, :underline]}, 
      {:text => " Dèpôt de " + @receipt.models.to_s + " dessins ou modéles"}
    ]

    move_down 20

    # Gathering data table for similar search
    
    data =
      [["Code", "Désignation", "Nombre", "Montant", "Total"],
      ["747-00", "Taxe fixe et independante du nombre de dessins et modèles déposé", "%02d" % 1, money_format(@receipt.base_tax), money_format(@receipt.base_tax)],
      ["747-01", "Taxe par dessin ou modèle", "%02d" % @receipt.models, money_format(@receipt.models_tax), money_format(@receipt.models_tax*@receipt.models)],
      ["747-04", "Taxe de maintient pour la seconde periode de protection de neuf ans, par dessin ou modèle", "%02d" % @receipt.models, money_format(@receipt.holding_tax), money_format(@receipt.holding_tax*@receipt.models)]]
      if @receipt.draws.positive?
        data += [["747-03", "Deposé sous forme de dessin industriel par vue", "%02d" % @receipt.draws, money_format(@receipt.draws_tax), money_format(@receipt.draws_tax*@receipt.draws)]]
      end
      if @receipt.pics.positive?
        data += [["747-03", "Deposé sous forme de photographie par vue", "%02d" % @receipt.pics, money_format(@receipt.pics_tax), money_format(@receipt.pics_tax*@receipt.pics)]]
      end

    # Last line of the table with total
    data += [["","","", "Total", money_format(@receipt.total)]]

    # Drawing mark taxe table
    detail_table_setting(data)
end