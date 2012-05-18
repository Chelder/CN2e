

#col = "idade_paciente: de_40_a_45_anos de_46_a_50_anos de_51_a_55_anos de_56_a_60_anos de_61_a_65_anos ate_40_anos acima_de_65_anos;"
#puts a = col.size
#puts col[a-1]

#linha = "if    idadepaciente == 'acimade65anos' "
#puts linha =~ /([a-zA-Z])+?([0-9])+?([a-zA-Z])+?([0-9])+?([a-zA-Z])+|\s([a-zA-Z])+\s/

#p $`
#p $&
#p $'

#linha = "compatibilidadehlab == \"nenhuma\""

#linha << " and"

#p linha

#require "../Sistema/traducao_se"

#x = TraducaoSe.new

#valor = " ENTÃO VOCÊ É CÃO"
#y = x.remover_acentos(valor)

#puts y

string = "if voce nao gosta de filmes end"

puts /(\w*\s?)*/.match(string)