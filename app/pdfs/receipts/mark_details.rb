private
def mark_detail(receipt)

    @receipt = receipt

    formatted_text [{:text => "Objet:", :styles => [:bold, :underline]}, 
      {:text => " Dépôt de la marque " + mark_type_text + " " + @receipt.mark_name}
    ]

    move_down 20

    # Gathering data table for mark taxe
    data =
      [["Code", "Désignation", "Nombre", "Montant", "Total"],
      ["746-01", @receipt.base_description, "%02d" % 1, money_format(@receipt.base_tax), money_format(@receipt.base_tax)]]
    data += [["746-02", @receipt.class_description, "%02d" % @receipt.classes, money_format(@receipt.class_tax), money_format(@receipt.class_tax*@receipt.classes)]]
    if @receipt.rev_pri? then
        data += [["746-03", @receipt.rev_description,"%02d" % 1, money_format(@receipt.rev_tax), money_format(@receipt.rev_tax)]]
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

# Methods mark color (designation and pricing) 
# def mark_color_designation()
#     if @receipt.colored == true then
#         return "TAXE DE DEPOT AVEC REVENDICATION DE COULEUR"
#     elsif @receipt.colored == false then
#         return "TAXE DE DEPOT SANS REVENDICATION DE COULEUR"
#     else
#         return "TYPE ERROR"
#     end
# end

# def mark_color_price()
#     if @receipt.colored == true then
#         return money_format(16000)
#     elsif @receipt.colored == false then
#         return money_format(15000)
#     else
#         return money_format(0)
#     end
# end

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