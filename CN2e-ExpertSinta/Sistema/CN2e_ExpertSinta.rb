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
vetorvar = Array.new
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
#Contadores utilizados na tradução do SE
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
#cont = 0;
#cont2 = 0;
#cont3 = 0;

#Variaveis utiliadas para alocação de valores temporários
#texto = ""
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
    linha = linha.gsub(regexs['='], "==")

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
  if linha =~ /and\s*/
    init_variavel = $'

    if init_variavel =~ /\s*=/
      variavel = $`
      variavelmod = variavel.gsub(/\s/, "_")
    end
  end

  linha = linha.gsub(/#{variavel}/, "#{variavelmod}")

  setraduzido[contr4] = linha
  contr4 += 1
end

#puts contr2
#puts selinhas
#puts selinhas[14].encoding.name
#selinhas[14].force_encoding("iso-8859-1")
#puts selinhas[14].encoding.name
puts setraduzido

#-------------------------------------------------------- tradução -------------------------------------------------#

#caminha em todas as posições do vetor traduzindo as strings do arquivo de regras
#while not rules.eof do

  #traducao = TraducaoSe.new

  #Pega uma linha do arquivo filmes_basedeconhecimento e guarda na posição contr do vetor selinhas
  #selinhas[contr] = rules.gets.chomp.to_s

  #Guarda o valor do vetor selinhas na posição contr para a variável linha
  #linha = selinhas[contr].to_s
  #Deixa todas as letras minúsculas
  #linha = linha.downcase
  #Remove acentos
  #Gem para remoção de acentos

  #linha = traducao.remover_acentos(linha)

  #selinhas[contr] = linha

  #Se não houver a palavra then na linha
#  if !(linha =~ regexs['then'])
#    #Troca o sinal de igual (=) por um sinal dúplo (==)
#    linha = linha.gsub(regexs['='], "==")
#  end

#  if linha =~ regexs['='] and !(linha =~ regexs['then'])
#    matrizvalores.each do |valor|
#        #O valor 'nao' está sendo encontrado e cortando o resto do tokem
#        if linha =~ /#{valor}/
#          tokem = $'
#          if tokem == "" or tokem =~ /(\s|\s\s)/
#            linha = linha.gsub(/#{valor}/, "\"#{valor}\"")
#          end
#        end
#    end
#  end

#  if linha =~ regexs['then']
#    matrizvalores.each do |valor|
#        if linha =~ /#{valor}\s/
#          tokem = $'
#          if tokem == "" or tokem =~ /(\s|\s\s)/ or tokem =~ regexs['end']
#            linha = linha.gsub(/#{valor}/, "\"#{valor}\"")
#          end
#        end
#    end
#  end

  #Guarda as strings traduzidas no vetor 'setraduzido'
#  if contr2 > 11
#    setraduzido[contr3] = linha
#    contr3 += 1
#  end

  #A linha precisa ser zerada para receber outra string
#  linha = nil
  #Incremento de contadores
#  contr2 += 1
  #contr += 1
#end

#puts selinhas

#Pega as veriaveis, guarda cada uma delas em uma posição do vetor sefinal e cria a instancia das variaveis
#setraduzido.each do |linha|
#  if !(linha == "")
#    variavel = /\w+\s\=/.match(linha).to_s
#    variavel << ' ""'
#    sefinal[cont2] = variavel
#    cont2 += 1
#  end
#end

#Tira os valores repetidos
#sefinal.uniq!
#Continua a contagem a partir do ultimo valor inserido
#cont2 = sefinal.length

#Concatena as linhas que contem and para tornar o SE compilável
#while not cont == setraduzido.length do
#  if !(setraduzido[cont] =~ regexs["then"])
#    texto << setraduzido[cont]
#  else
#    textothen = setraduzido[cont]
#    sefinal[cont2] = texto
#    cont2 += 1
#    sefinal[cont2] = textothen
#    cont2 += 1
#
#    texto = ""
#  end
#
#  cont += 1
#end

#Imprime cada valor contido no vetor de regras com as strings traduzidas
#setraduzido.each do |linhat|
  #puts "#{linhat}"
#end

#imprime cada valot contido no vetor com o SE final e compilável
#sefinal.each do |linhat|
#  puts "#{linhat}"
#end

#fecha os arquivos
#rules.close
#values.close

#Cria o arquivo ambulancia.rb
#exit = File.new("ambulancia.rb", "w")

#Grava o Sistema Especialista em ruby no arquivo
#sefinal.each do |linhat|
#  exit.puts "#{linhat}"
#end
