#encoding UTF-8

#Sistema de tradução CN2e-ExpertSinta
#Desenvolvido pelo laboratório de inteligência computacional do UnilesteMG - LIC
#Autores: Francisco Reinaldo, Demétrio Magalhães, Chelder Simão
# ---------------- // ---------------- 

#Importa classes
require "../Sistema/traducao_se"


#Abre o arquivo desejado
rules = File.open("filmes_basedeconhecimento.txt")

#Declaração dos arrays utilizados
#Array utilizado para guardar cada linha do Sistema Especialista
selinhas = Array.new
#Array com o Sistema Especialista traduzido, faltando a concatenação
setraduzido = Array.new
#Array com as variaveis para inicialização
valores = Array.new
#Array com a versão final do Sistema Especialista traduzido
sefinal = Array.new

#Hash com regexs
regexs = Hash[ 'SE' => /SE/,
               'E' => /\sE\s/,
               'ENTAO' => /ENTAO/,
               '=' => /=/,
               'then' => /then/,
               'end' => /end/,
               'espaco' => /\s/,
               'identvalores' => /([a-zA-Z])+?([0-9])+?([a-zA-Z])+?([0-9])+?([a-zA-Z])+|\s([a-zA-Z])+\s|([a-zA-Z])+?([0-9])+?([a-zA-Z])+/,
               'CNF' => /.\sCNF\s\d*%/,
               'Regra' => /Regra\s\d*/,
               'REGRAS' => /REGRAS/,
               'PERG' => /PERGUNTAS/,
               #regexp que encontra frases
               'frases' => /(\w*\s?)*/
              ]

#Inicialização de variáveis
#Contadores
contr = 0
contr2 = 10000000000
contr3 = 0
contr4 = 0

#Contadores utilizados na tradução do dos valores
#contv = 0
#contv2 = 0
#contv3 = 0

#Contadores da matriz
#contmatriz = 0
#contvetor = 0

#Contadores utilizados na contatenação das condições do IF
cont = 0;
cont2 = 0;

#Variaveis utiliadas para alocação de valores temporários
texto = ""
#textothen = ""


#col = ""
#col2 = ""
#tokem = ""

#-------------------------------------------------------- Filtro ---------------------------------------------------#

aux = Array.new
tr = TraducaoSe.new

while not rules.eof do
  aux[contr] = rules.gets.chomp.to_s
  linha = aux[contr].to_s
  linha = linha.force_encoding("UTF-8")

  #Quando encontra a palavra "REGRAS" ele começa a inserir as linhas no vetor.
  #Quando encontra a palavra "PERGUNTAS" ele para de inserir as linhas no vetor.
  if linha =~ regexs['REGRAS']
    contr2 = contr
  elsif linha =~ regexs['PERG']
    break
  end

  if contr > contr2
	  linha = tr.remover_acentos(linha)

    if !(linha =~ /then/)
      linha = linha.gsub(regexs['='], "==")
    end

    if linha =~ regexs['SE']
      linha = linha.gsub(regexs['SE'], "if")
    elsif linha =~ regexs['ENTAO']
      linha = linha.gsub(regexs['ENTAO'], "then")
      linha = linha.gsub(regexs['CNF'], " end")
    elsif linha =~ regexs['E']
      linha = linha.gsub(regexs['E'], "and ")
    elsif linha =~ regexs['Regra']
      linha = linha.gsub(regexs['Regra'], "")
    end

    linha = linha.downcase

    selinhas[contr3] = linha
    contr3 += 1
  end

  contr += 1
end

selinhas.each do |linha|
  if !(linha =~ regexs['then']) and (linha =~ /and / or linha =~ /if /)
    /\w*$/.match(linha)
    var = $&
    linha = linha.gsub("#{var}", "\"#{var}\"")
  end

  if linha =~ /if\s+/ or linha =~ /and\s+/ or linha =~ /then\s+/
    linha = linha.gsub(/\s+if/, "if")
    linha = linha.gsub(/\s+and/, "and")
    linha = linha.gsub(/\s+then/, "then")
  end

  if linha =~ /if\s+/ or linha =~ /and\s+/ or linha =~ /then\s+/
    init_variavel = $'

    if init_variavel =~ /\s*=/
      variavel = $`
      variavelmod = variavel.gsub(/\s/, "_")
    end
  end

  if linha =~ regexs['then']
    /=\s/.match(linha)
    init_valor = $'

    if init_valor =~ /\send/
      valor = $`
      valormod = valor.gsub("#{valor}", "\"#{valor}\"")
    end
  end

  linha = linha.gsub(/#{variavel}/, "#{variavelmod}")
  linha = linha.gsub(/#{valor}/, "#{valormod}")

  setraduzido[contr4] = linha
  contr4 += 1
end

#Pega as veriaveis, guarda cada uma delas em uma posição do vetor sefinal e cria a instancia das variaveis
#setraduzido.each do |linha|
#  if !(linha == "")
#    variavel = /\w+\s+\=/.match(linha).to_s
#    variavel << ' ""'
#    sefinal[cont2] = variavel
#    cont2 += 1
#  end
#end

#Tira os valores repetidos
sefinal.uniq!
#Continua a contagem a partir do ultimo valor inserido
cont2 = sefinal.length

#Concatena as linhas que contem and para tornar o SE compilável
#while not cont == setraduzido.length do
#  if !(setraduzido[cont] =~ regexs["then"])
#    texto << " " << setraduzido[cont]
#  else
#    textothen = setraduzido[cont]
#    sefinal[cont2] = texto
#    cont2 += 1
#    sefinal[cont2] = textothen
#    cont2 += 1
#
#    texto = ""
#  end

#  cont += 1
#end

#puts contr2
puts selinhas
#puts selinhas[14].encoding.name
#selinhas[14].force_encoding("iso-8859-1")
#puts selinhas[14].encoding.name
#puts setraduzido
#p valores
puts sefinal

#fecha os arquivos
rules.close

#Cria o arquivo
#file = File.new("filmes.rb", "w")

#Grava o Sistema Especialista em ruby no arquivo
#sefinal.each do |linhat|
#  file.puts "#{linhat}"
#end
