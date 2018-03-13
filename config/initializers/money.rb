require 'money'

curr = {
    :priority        => 1,
    :iso_code        => "DZ",
    :iso_numeric     => "213",
    :name            => "Dinar Algerien",
    :symbol          => "DA",
    :subunit         => "Cent",
    :subunit_to_unit => 100,
    :separator       => ",",
    :delimiter       => " "
  }
  
  Money::Currency.register(curr)