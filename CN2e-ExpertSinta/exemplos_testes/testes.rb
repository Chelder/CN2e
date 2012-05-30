

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

#string = "if voce nao gosta de filmes end"

#puts /(\w*\s?)*/.match(string)

#string = "and  envolve crime guerra ou policia == nao"

#/\w*$/.match(string)
#p var = $&
#puts string = string.gsub("#{var}", "\"#{var}\"")

#p $`
#p $&
#p $'


#if string =~ /and\s*/
#  init_variavel = $'
#
#  if init_variavel =~ /\s*=/
#    variavel = $`
#    variavelmod = variavel.gsub(/\s/, "_")
#  end
#end

#puts string = string.gsub(/#{variavel}/, "#{variavelmod}")



#puts init_variavel
#puts variavel

#puts string =~ /and\s*/

#p $`
#p $&
#p $'

#puts string =~ /\s*=/

#p $`
#p $&
#p $'

#linha = "and  a maioria das pessoas tem dificuldade de entender a mensagem do filme == \"nao\""

#if linha =~ /if\s+/ or linha =~ /and\s+/ or linha =~ /then\s+/
#    init_variavel = $'
#
#    if init_variavel =~ /\s*=/
#      variavel = $`
#      variavelmod = variavel.gsub(/\s/, "_")
#    end
#end

#puts variavel
#puts variavelmod

linha = "then resultado == voce nao gosta de filmes end"

if linha =~ /then/
  /=\s/.match(linha)
  init_valor = $'

  if init_valor =~ /\send/
    valor = $`
    valormod = valor.gsub("#{valor}", "\"#{valor}\"")
  end
end

puts valor
puts valormod