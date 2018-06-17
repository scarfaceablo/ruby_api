require 'csv'
csv_text = File.read('rs_drugs_1000.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  #puts row[0]
  #puts row[1]
  Drug.create!(id_drug: row[0],
    registered_name:row[1],
    active_ingredient:row[2],
    pharmaceutical_form:row[3],
    insurance_list:row[4],
    issuing:row[5],
    atc:row[6],
    license_holder:row[7])
    puts row
end