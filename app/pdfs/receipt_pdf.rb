require 'prawn'
require 'prawn/table'
require 'arabic-letter-connector'
require 'money'
require 'humanize'
require_relative 'mark_details'
require "bidi"
# bidi.to_visual
class ReceiptPdf < Prawn::Document
  def initialize(receipt)
    super()
    file = Rails.root.join('app', 'assets', 'fonts', 'Amiri-Regular.ttf')
    file2 = Rails.root.join('app', 'assets', 'fonts', 'Amiri-Bold.ttf')
    logo = Rails.root.join('app', 'assets', 'images', 'inapi_logo.png')
    font_families.update("Amiri" => {
    :normal => file,
    :bold => file2,
    })
    font "Amiri"
    self.text_direction = :ltr
    @receipt = receipt
    bidi = Bidi.new

    header_ar_radp = "République Algérienne Démocratique et Populaire" + bidi.to_visual(" الجمهورية الجزائرية الديموقراطية الشعبية ".connect_arabic_letters)
    header_ar_inapi = "Institut National Algérien de la Propriété Industrielle" + bidi.to_visual("المعهد الوطني الجزائري للملكية الصناعية ".connect_arabic_letters)
    receipt_header =
      [[{:image => logo, :fit => [75, 75], :rowspan => 2},
        header_ar_radp,{:content => "Code R1-FO/01", :colspan => 2}],
      [header_ar_inapi,"Edition 1"," Page 1/1"]
      ]
    table(receipt_header, width: bounds.width) do
      row(0..1).column(1..3).size = 10
      row(0..1).column(1..3).align = :center
    end

    receipt_family = "U"
    if @receipt.class.superclass.name == "MdReceipt" then
      receipt_family = "M"
    elsif @receipt.class.superclass.name == "PdReceipt" then
      receipt_family = "P"
    end

    move_down 20
    text "Quittance de Taxe", :align => :center, :size => 20
    date_number = [["#{@receipt.created_at.strftime('%d-%m-%Y')}", "#{@receipt.serie}/#{@receipt.number}/#{receipt_family}"]]
    table(date_number, :position => :right, :cell_style => { leading: 0, :padding_top => -5, :padding_bottom => 1 })

    move_down 20
    formatted_text [{:text => "Demandeur:", :styles => [:bold, :underline]}, 
      {:text => " " + @receipt.owner_name}
    ]
    formatted_text [{:text => "Adresse:", :styles => [:bold, :underline]}, 
      {:text => " " + @receipt.owner_street + " - " + @receipt.owner_wilaya}
    ]

    unless @receipt.representative.nil?
      formatted_text [{:text => "Mandataire:", :styles => [:bold, :underline]}, 
        {:text => " " + @receipt.representative.fullname}
      ]
      formatted_text [{:text => "Adresse/Mand:", :styles => [:bold, :underline]}, 
        {:text => " " + @receipt.representative.adress + " - " + @receipt.representative.wilaya}
      ]
    end
    
    if (@receipt.type == "MarkReceipt") then
      mark_detail(@receipt)
    end

    move_down 20
    formatted_text [{:text => "Arrête la presente quittance a la somme de:", :styles => [:bold, :underline]}, 
      {:text => " " + @receipt.total.humanize(locale: :fr).humanize + " dinars algérien"}
    ]

    move_down 40
    formatted_text [{:text => "Signature: ", :styles => [:bold, :underline]}], :align => :right
  end

private
  def money_format(value)
    return Money.new(value*100, "DZ").format(:translate => true, :symbol_position => :after)
  end


end
