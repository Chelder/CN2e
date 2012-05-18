#Sistema de tradução CN2e-CN2
#Desenvolvido pelo laboratório de inteligência computacional do UnilesteMG - LIC
#Autores: Francisco Reinaldo, Demétrio Magalhães, Chelder Simão
# ---------------- // ------------------

#Abre o arquivo desejado
rules = File.open("andreia.rules")
values = File.open("andreia.att")

#Declaração dos arrays utilizados
linhastexto = Array.new
textotraduzido = Array.new
linhasvalores = Array.new
valortraduzido = Array.new
matriz = Array.new
vetvalores = Array.new
final = Array.new

#Hash com regexs
regexs = Hash[ 'colchetes' => /\[([0-9]{1,2}\s?)+\]/,
               'default' => /default/,
               'def_parenteses' => /\(default\)\s/,
               'sinal_igual' => /=/,
               'and' => /and/,
               'then' => /then/,
               'end' => /end/,
               'pontovirg' => /;/,
               'underscore' => /_/,
               'espaco' => /\s/,
               'identvalores' => /([a-zA-Z])+?([0-9])+?([a-zA-Z])+?([0-9])+?([a-zA-Z])+|\s([a-zA-Z])+\s|([a-zA-Z])+?([0-9])+?([a-zA-Z])+/
              ]

#Inicialização de variáveis
linr = 0
linr2 = 0
linr3 = 0
linv = 0
linv2 = 0
linv3 = 0

col = ""
col2 = ""
tokem = ""

#aloca cada linha do arquivo de valores em uma posição do vetor
#while not values.eof do
#  linhasvalores[linv] = values.gets.chomp.to_s
#  puts "#{linv}: #{linhasvalores[linv]}"
#  linv += 1
#end

#caminha em todas as posições do vetor traduzindo as strings do arquivo de valores
while not values.eof do
  linhasvalores[linv] = values.gets.chomp.to_s

  linha = linhasvalores[linv].to_s
  linha = linha.downcase
  linha = linha.gsub(regexs['underscore'], "")
  linha = linha.gsub(regexs['pontovirg'], " ")

  #Guarda a string traduzida no vetor se a posição da linha for maior que 1
  if linv2 > 1
    valortraduzido[linv3] = linha
    linv3 += 1
  end

  #A linha precisa ser zerada para receber outra string
  linha = nil

  linv2 += 1
  linv += 1
end

#Zera a variável linv2 para reutilizá-la no código abaixo que imprime o valor da matriz
#linv2 = 0
#puts ""

#Imprime cada valor contido no vetor de valores com as strings traduzidas
#valortraduzido.each do |valort|
#  puts "#{linv2}: #{valort}"
#  linv2 += 1
#end

contmatriz = 0
contvetor = 0

#Pega cada posição do vetor de valores e os guarda em uma matriz
linv2.times do
  indvetor = 0
  v = []

  col = col2 = valortraduzido[contvetor].to_s

  while not indvetor == col.size do
    if col2 =~ regexs['identvalores']
      v[indvetor] = $&
      col2 = " #{$'}"
    end
    indvetor += 1
  end

  matriz[contmatriz] = v

  contvetor += 1
  contmatriz += 1
end

#puts "\n"

#A matriz é, na verdade, um vetor de vetores. Portanto, o bloco abaixo imprime cada vetor contido no vetor principal (matriz)
#matriz.each do |indmatriz|
#  print "#{indmatriz} \n"
#end

#Flatten junta todos os arrays em um só e o uniq tira todos os valores repetidos
matriz.flatten!.uniq!

#Tira os espaços da string
matriz.each do |valor|
  valor.strip!
end

#print "\n #{matriz}"

#-------------------------------------------------------- tradução -------------------------------------------------#

#puts ""

#aloca cada linha do arquivo de regras em uma posição do vetor
#while not rules.eof do
#  linhastexto[linr] = rules.gets.chomp.to_s
#  puts "#{linr}: #{linhastexto[linr]}"
#  linr += 1
#end

#puts ""

#caminha em todas as posições do vetor traduzindo as strings do arquivo de regras
while not rules.eof do
  linhastexto[linr] = rules.gets.chomp.to_s

  linha = linhastexto[linr].to_s
  linha = linha.downcase

  linha = linha.gsub(regexs['underscore'], "")

  if linha =~ regexs['default']
    linha = linha.gsub(regexs['def_parenteses'], "")
    linha = linha.gsub(regexs['colchetes'], "")
  else
    linha = linha.gsub(regexs['colchetes'], " end")
  end

  if !(linha =~ regexs['then'])
    linha = linha.gsub(regexs['sinal_igual'], "==")
  end

  if linha =~ regexs['sinal_igual'] and !(linha =~ regexs['then'])
    matriz.each do |valor|
        #O valor 'nao' está sendo encontrado e cortando o resto do tokem
        if linha =~ /#{valor}/
          tokem = $'
          if tokem == "" or tokem =~ /(\s|\s\s)/
            linha = linha.gsub(/#{valor}/, "\"#{valor}\"")
          end
        end
    end
  end

  if linha =~ regexs['then']
    matriz.each do |valor|
        if linha =~ /#{valor}\s/
          tokem = $'
          if tokem == "" or tokem =~ /(\s|\s\s)/ or tokem =~ regexs['end']
            linha = linha.gsub(/#{valor}/, "\"#{valor}\"")
            #linha = linha.gsub(regexs['then'], "")
          end
        end
    end
  end

  #Guarda as strings traduzidas no vetor 'textotraduzido'
  if linr2 > 11
    textotraduzido[linr3] = linha
    linr3 += 1
  end

  #A linha precisa ser zerada para receber outra string
  linha = nil

  linr2 += 1
  linr += 1
end

linr2 = 0

#Imprime cada valor contido no vetor de regras com as strings traduzidas
textotraduzido.each do |linhat|
  puts "#{linhat}"
  linr2 += 1
end

#print matriz

#p textotraduzido[linr2-1]

#fecha o arquivo
rules.close
values.close

  #exit = File.new("ambulamcia.rb", "w")

#textotraduzido.each do |linhat|
#  exit.puts "#{linhat}"
#end

