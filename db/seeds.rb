tax_list = [
    [ "746-01", "Taxe de dépôt sans revendication de couleurs", "uncolored",  14000],
    [ "746-01", "Taxe de dépôt avec revendication de couleurs", "colored",  15000],
    [ "746-01", "Taxe de renouvellement", "renew",  15000],
    [ "746-02", "Taxe d'enregistrement par classe de produit ou service", "class",  2000],
    [ "746-03", "Taxe de revendication de priorité", "rev",  1000],
    [ "746-07", "Taxe de Recherche a l'identique par marque", "base",  1600],
    [ "746-07", "Taxe de Recherche a l'identique au delà d'une classe supplémentaire", "class",  400],
    [ "746-08", "Taxe de Recherche de Similitude / ou par déposant dans 3 classes", "base",  3000],
    [ "746-08", "Taxe au delà de la 3ème classe/ ou par déposant dans 3 classes", "class",  3000],
    [ "746-09", "Taxe de rectification d'erreur materiel", "error",  400],
    [ "746-15", "Taxe National pour la demande d'enregistrement international ou de renouvellement", "int",  4000],
    [ "747-00", "Taxe fixe et independante du nombre de dessins et modèles déposé", "base",  10000],
    [ "747-01", "Taxe par dessin ou modèle", "model",  1000],
    [ "747-03", "Deposé sous forme de dessin industriel par vue", "draws",  500],
    [ "747-03", "Deposé sous forme de photographie par vue", "pictures",  2000],
    [ "747-04", "Taxe de maintient pour la seconde periode de protection de neuf ans, par dessin ou modèle", "holding",  1000]
    
    
  ]

  tax_list.each do |code, description, category, current_tax|
    Tax.find_or_create_by( code: code, description: description, category: category, current_tax: current_tax )
  end

  group_list = [
      ["Oran", "oran", "08 Rue Ferh el Hadj, Boulanger", "inapi-oran@inapi.org"],
      ["Alger", "alger", "42 Rue Larbi ben Mhidi", "mail1@exemple.dz"],
      ["Setif", "setif", "Setif", "mail2@exemple.dz"]
    ]

  group_list.each do |name, tenant, adress, email|
    Group.find_or_create_by( name: name, tenant: tenant, adress: adress, email: email)
  end

  white_list = [
    ["127.0.0.1", "Local"],
    ["41.111.128.254", "Direction Générale"],
    ["105.96.80.98", "Annexe d'Oran"]
  ]

  white_list.each do |ip_adress, description|
    Whitelist.find_or_create_by(ip_adress: ip_adress, description: description)
  end
  