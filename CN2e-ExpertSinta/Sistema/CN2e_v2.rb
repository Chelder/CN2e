#Sistema de tradução CN2e-CN2
#Desenvolvido pelo laboratório de inteligência computacional do UnilesteMG - LIC
#Autores: Francisco Reinaldo, Demétrio Magalhães, Chelder Simão
# ---------------- // ------------------

#Abre o arquivo desejado
rules = File.open("andreia.rules")
values = File.open("andreia.att")

#Declaração dos arrays utilizados
#Array utilizado para guardar cada linha do Sistema Especialista
linhasse = Array.new
#Array com o Sistema Especialista traduzido, faltando a concatenação
setraduzido = Array.new
#Array utilizado para guardar os valores do arquivo andreia.att
linhasvalores = Array.new
#Array com os valores traduzidos para serem utilizados na tradução do Sistema especialista
valortraduzido = Array.new
#Matriz com os valores do arquivo andreia.att
matrizvalores = Array.new
#Array com as variaveis para inicialização
vetorvar = Array.new
#Array com a versão final do Sistema Especialista traduzido
sefinal = Array.new

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
#Contadores utilizados na tradução do SE
linr = 0
linr2 = 0
linr3 = 0

#Contadores utilizados na tradução do dos valores
linv = 0
linv2 = 0
linv3 = 0

#Contadores da matriz
contmatriz = 0
contvetor = 0

#Contadores utilizados na contatenação das condições do IF
cont = 0;
cont2 = 0;

#Variaveis utiliadas para alocação de valores temporários
texto = ""
textothen = ""


col = ""
col2 = ""
tokem = ""

#Caminha em todas as posições do vetor traduzindo as strings do arquivo de valores andreia.att
while not values.eof do
  #Pega a primeira linha do arquivo andreia.att e guarda no vetor como String
  linhasvalores[linv] = values.gets.chomp.to_s

  #Guarda o valor da posição linv na variável linha como String
  linha = linhasvalores[linv].to_s
  #Deixa todas as letras da linha minúsculas
  linha = linha.downcase
  #Remove todos os underscores (_) dos valores
  linha = linha.gsub(regexs['underscore'], "")
  #Substitui os ponto e virgulas (;) por espaço em branco
  linha = linha.gsub(regexs['pontovirg'], " ")

  #Guarda a string traduzida no vetor se a posição da linha for maior que 1
  if linv2 > 1
    valortraduzido[linv3] = linha
    linv3 += 1
  end

  #A linha precisa ser zerada para receber outra string
  linha = nil
  #Incremento de contadores
  linv2 += 1
  linv += 1
end

#Pega cada posição do vetor de valores e os guarda em uma matriz
linv2.times do
  #Posição do vetor
  indvetor = 0
  v = []

  #col e col2 recebem o valor contido na posição contvetor do vetor de valores traduzidos
  col = col2 = valortraduzido[contvetor].to_s

  #Filtra o valor e o guarda no vetor V
  while not indvetor == col.size do
    if col2 =~ regexs['identvalores']
      v[indvetor] = $&
      col2 = " #{$'}"
    end
    indvetor += 1
  end
  #Guarda uma linha inteira do arquivo de valores andreia.att em uma posição do vetor matrizvalores, fomando
  #assim uma matriz
  matrizvalores[contmatriz] = v
  #Incremento de contadores
  contvetor += 1
  contmatriz += 1
end


#Flatten junta todos os arrays em um só e o uniq tira todos os valores repetidos
matrizvalores.flatten!.uniq!

#Tira os espaços da string
matrizvalores.each do |valor|
  valor.strip!
end

#-------------------------------------------------------- tradução -------------------------------------------------#

#caminha em todas as posições do vetor traduzindo as strings do arquivo de regras
while not rules.eof do
  #Pega uma linha do arquivo de regras andreia.rules e guarda na posição linr do vetor linhasse
  linhasse[linr] = rules.gets.chomp.to_s

  #Guarda o valor do vetor linhasse na posição linr para a variável linha
  linha = linhasse[linr].to_s
  #Deixa todas as letras minúsculas
  linha = linha.downcase

  #Remove todos os underscores (_)
  linha = linha.gsub(regexs['underscore'], "")

  #Se encontrar a palavra default
  if linha =~ regexs['default']
    #Remove a palavra default juntamente com os parenteses
    linha = linha.gsub(regexs['def_parenteses'], "")
    #Remove os colchetes e números contidos dentro deles na linha da palavra default
    linha = linha.gsub(regexs['colchetes'], "")
  else
    #Remove os colchetes e números contidos dentro deles
    linha = linha.gsub(regexs['colchetes'], " end")
  end

  #Se não houver a palavra then na linha
  if !(linha =~ regexs['then'])
    #Troca o sinal de igual (=) por um sinal dúplo (==)
    linha = linha.gsub(regexs['sinal_igual'], "==")
  end

  if linha =~ regexs['sinal_igual'] and !(linha =~ regexs['then'])
    matrizvalores.each do |valor|
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
    matrizvalores.each do |valor|
        if linha =~ /#{valor}\s/
          tokem = $'
          if tokem == "" or tokem =~ /(\s|\s\s)/ or tokem =~ regexs['end']
            linha = linha.gsub(/#{valor}/, "\"#{valor}\"")
          end
        end
    end
  end

  #Guarda as strings traduzidas no vetor 'setraduzido'
  if linr2 > 11
    setraduzido[linr3] = linha
    linr3 += 1
  end

  #A linha precisa ser zerada para receber outra string
  linha = nil
  #Incremento de contadores
  linr2 += 1
  linr += 1
end

#Pega as veriaveis, guarda cada uma delas em uma posição do vetor sefinal e cria a instancia das variaveis
setraduzido.each do |linha|
  if !(linha == "")
    variavel = /\w+\s+\=/.match(linha).to_s
    variavel << ' ""'
    sefinal[cont2] = variavel
    cont2 += 1
  end
end

#Tira os valores repetidos
sefinal.uniq!
#Continua a contagem a partir do ultimo valor inserido
cont2 = sefinal.length

#Concatena as linhas que contem and para tornar o SE compilável
while not cont == setraduzido.length do
  if !(setraduzido[cont] =~ regexs["then"])
    texto << " " << setraduzido[cont]
  else
    textothen = setraduzido[cont]
    sefinal[cont2] = texto
    cont2 += 1
    sefinal[cont2] = textothen
    cont2 += 1

    texto = ""
  end

  cont += 1
end

#Imprime cada valor contido no vetor de regras com as strings traduzidas
#setraduzido.each do |linhat|
#  puts "#{linhat}"
#end

#imprime cada valot contido no vetor com o SE final e compilável
sefinal.each do |linhat|
  puts "#{linhat}"
end

#fecha os arquivos
rules.close
values.close

#Cria o arquivo ambulancia.rb
file = File.new("ambulancia.rb", "w")

#Grava o Sistema Especialista em ruby no arquivo
sefinal.each do |linhat|
  file.puts "#{linhat}"
end


