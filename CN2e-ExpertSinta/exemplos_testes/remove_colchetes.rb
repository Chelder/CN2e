#teste para desenvolver uma regex que remova tudo que está entre os colchetes

v = []
col = "idadepaciente: dez quinze de40a45anos de46a50anos de51a55anos de56a60anos de61a65anos ate40anos acimade65anos onze "
#col.downcase
#col = "123 23 2 rtyuio[31 21 11 25 8 13 5]"
#col = "[12] [1] [2] [21] [1]"
#col = col.gsub(/[0-9]{1,2}\s[0-9]{1,2}\s[0-9]{1,2}\s[0-9]{1,2}\s[0-9]{1,2}\s[0-9]{1,2}\s[0-9]{1,2}/, "end")
#col = col.gsub(/(\[[0-9]{1,2}\s?\])+/, " end")
puts col =~ /([a-zA-Z])+?([0-9])+?([a-zA-Z])+?([0-9])+?([a-zA-Z])+|\s([a-zA-Z])+\s/
#puts col =~ //                                \s([a-zA-Z])+;
#puts col =~ /(\w)+/ # \w pega caracteres mais underscores (_)
p $`
p $&
p $'

cont = 0
col2 = col

while not cont == col.size do
  if col2 =~ /([a-zA-Z])+?([0-9])+?([a-zA-Z])+?([0-9])+?([a-zA-Z])+|\s([a-zA-Z])+\s|([a-zA-Z])+?([0-9])+?([a-zA-Z])+/
    v[cont] = $&
    col2 = " #{$'}"
  end
  cont += 1
end

print v
puts v.size