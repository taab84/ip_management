private
def mark_detail(receipt)

    @receipt = receipt

    formatted_text [{:text => "Objet:", :styles => [:bold, :underline]}, 
      {:text => " Dépôt de la marque " + mark_type_text + " " + @receipt.mark_name}
    ]

    move_down 20

    if @receipt.colored? then
      base_description = "Taxe de dépôt avec revendication de couleurs"
    else
      base_description = "Taxe de dépôt sans revendication de couleurs"
    end

    # Gathering data table for mark taxe
    data =
      [["Code", "Désignation", "Nombre", "Montant", "Total"],
      ["746-01", base_description, "%02d" % 1, money_format(@receipt.base_tax), money_format(@receipt.base_tax)]]
    data += [["746-02", "Taxe d'enregistrement par classe de produit ou service", "%02d" % @receipt.classes, money_format(@receipt.class_tax), money_format(@receipt.class_tax*@receipt.classes)]]
    if @receipt.rev_pri? then
        data += [["746-03", "Taxe de revendication de priorité","%02d" % 1, money_format(@receipt.rev_tax), money_format(@receipt.rev_tax)]]
    end
    if @receipt.international? then
      data += [["746-15", "Taxe National pour la demande d'enregistrement international ou de renouvellement","%02d" % 1, money_format(@receipt.int_tax), money_format(@receipt.int_tax)]]
    end
    
    # Last line of the table with total
    data += [["","","", "Total", money_format(@receipt.total)]]

    # Drawing mark taxe table
    detail_table_setting(data)
end

# generate text for mark type
def mark_type_text
    if @receipt.mark_type == "figuratif"
        return "(Figurative)"
    elsif @receipt.mark_type == "verbal"
        return "(Verbale)"
    elsif @receipt.mark_type == "figuratif_and_verbal"
        return "(Figurative et Verbale)"
    else
        return "(Undefined)"
    end
end