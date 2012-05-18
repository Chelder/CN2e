
#Abre o arquivo desejado
file = File.open("andreia.att")

#Declaração dos arrays utilizados
linhastexto = Array.new
textotraduzido = Array.new
matriz = []

#Hash com Regexs
regexs2 = Hash['pontovirg' => /;/,
               'underscore' => /_/,
               'identvalores' => /([a-zA-Z])+?([0-9])+?([a-zA-Z])+?([0-9])+?([a-zA-Z])+|\s([a-zA-Z])+\s|([a-zA-Z])+?([0-9])+?([a-zA-Z])+/
                ]

#Inicialização de variáveis
lin = 0
lin2 = 0
lin3 = 0

col = ""
col2 = ""

#Aloca cada linha do arquivo de texto em uma posição do vetor
while not file.eof do
  linhastexto[lin] = file.gets.chomp.to_s
  puts "#{lin}: #{linhastexto[lin]}"
  lin = lin + 1
end

#identação do console
p ""

#caminha em todas as posições do vetor traduzindo as strings
linhastexto.each do |linhas|

  linha = linhas.to_s
  linha = linha.downcase
  linha = linha.gsub(regexs2['underscore'], "")
  linha = linha.gsub(regexs2['pontovirg'], " ")

  #Guarda a string traduzida no vetor se a posição da linha for maior que 1
  if lin2 > 1
    textotraduzido[lin3] = linha
    lin3 = lin3 + 1
  end

  #A linha precisa ser zerada para receber outra string
  linha = nil

  lin2 = lin2 + 1

end

#Teste para ver se a matriz foi alocada
#print matriz[2][0]

#Zerei a variável para não precisar criar outra
lin2 = 0

#Imprimi cada valor contido no vetor com as strings traduzidas
textotraduzido.each do
  puts "#{lin2}: #{textotraduzido[lin2]}"
  lin2 = lin2 + 1
end

#Gera uma matriz com a quantidade de linhas que há no texto
#lin2.times do
#  matriz << nil #"teste: #{cont} "
#  #cont = cont + 1
#end

#Toda posição terminada com 0 deve conter uma variável (0,0;0,1;0,2...)
#As demais posições devem conter os valores das respectivas variáveis

#Teste para ver como ficou a matriz
#matriz[0][0] = "celula 0"
#matriz[1][0] = "celula 1"
#matriz[2][0] = "celula 2"
#matriz[3][0] = "celula 3"
#matriz[4][0] = "celula 4"
#matriz[5][0] = "celula 5"
#matriz[6][0] = "celula 6"
#matriz[7][0] = "celula 7"
#matriz[8][0] = "celula 8"
#matriz[9][0] = "celula 9"
#matriz[10][0] = "celula 10"
#matriz[11][0] = "celula 11"
#matriz[12][0] = "celula 12"
#matriz[13][0] = "celula 13"

#matriz[0][0] = "celula 0"
#matriz[0][1] = "celula 1"
#matriz[0][2] = "celula 2"
#matriz[0][3] = "celula 3"
#matriz[0][4] = "celula 4"
#matriz[0][5] = "celula 5"
#matriz[0][6] = "celula 6"
#matriz[0][7] = "celula 7"
#matriz[0][8] = "celula 8"
#matriz[0][9] = "celula 9"
#matriz[0][10] = "celula 10"
#matriz[0][11] = "celula 11"
#matriz[0][12] = "celula 12"
#matriz[0][13] = "celula 13"

#matriz[0][1] = 2
#atriz[0][4] = 3
#matriz[2][0] = 4
#matriz[3][5] = 5

#Quiz visualisar a matriz mas criei uma matriz 14x14. Creio ter dado certo, qualquer coisa volto aqui
#for linha in (0...lin2) do
#  for coluna in (0...lin2) do
#    puts matriz[linha][coluna]
#  end
#end

contmatriz = 0
contvetor = 0

#puts "------------------------------------------------------"
#puts "TESTE TESTE TESTE TESTE TESTE TESTE TESTE TESTE TESTE "
#puts "------------------------------------------------------"

lin2.times do
#matriz.each do
  indvetor = 0
  v = []

  col = col2 = textotraduzido[contvetor].to_s

  while not indvetor == col.size do
    if col2 =~ regexs2['identvalores']
      v[indvetor] = $&
      col2 = " #{$'}"
    end
    indvetor += 1
  end

  matriz[contmatriz] = v

  contvetor += 1
  contmatriz += 1
end

puts "\n"

#A matriz é, na verdade, um vetor de vetores. Portanto, o bloco abaixo imprimi cada vetor contido no vetor principal
#O vetor principal sempre possui
cont = 0
matriz.each do
  print "#{matriz[cont]} \n"
  cont += 1
end

#Imprimi a matriz para visualisar se ela foi alocada corretamente
print "\n #{matriz}"