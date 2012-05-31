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
#Array com a versão final do Sistema Especialista traduzido
sefinal = Array.new
#Array auxiliar
aux = Array.new
#Classe traducaoSe
tr = TraducaoSe.new

#Hash com regexs
regexs = Hash[ 'SE' => /SE/,
               'E' => /\sE\s/,
               'ENTAO' => /ENTAO/,
               '=' => /=/,
               'then' => /then/,
               'end' => /end/,
               'espaco' => /\s/,
               'CNF' => /.\sCNF\s\d*%/,
               'Regra' => /Regra\s\d*/,
               'REGRAS' => /REGRAS/,
               'PERG' => /PERGUNTAS/,
               #regexp que encontra frases
               'frases' => /(\w*\s?)*/,
               'andesp' => /and\s+/,
               'ifesp' => /if\s+/,
               'thenesp' => /then\s+/,
               'espif' => /\s+if/,
               'espand' => /\s+and/,
               'espthen' => /\s+then/,
               'ultpalavra' => /= \w+$/,
               '=esp' => /=\s/,
               'variavel' => /\w+\s+\=/
              ]

#Inicialização de variáveis
#Contadores
contr = 0
contr2 = 10000000000
contr3 = 0
contr4 = 0

#Contadores utilizados na contatenação das condições do IF
cont = 0;
cont2 = 0;

#Variaveis utiliadas para alocação de valores temporários
texto = ""

#-------------------------------------------------------- Filtro ---------------------------------------------------#

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
    linha = tr.remover_especial(linha)

    if linha =~ regexs['SE']
      linha = linha.gsub(regexs['SE'], "if")
    elsif linha =~ regexs['ENTAO']
      linha = linha.gsub(regexs['ENTAO'], "then").gsub(regexs['CNF'], " end")
    elsif linha =~ regexs['E']
      linha = linha.gsub(regexs['E'], "and ")
    elsif linha =~ regexs['Regra']
      linha = linha.gsub(regexs['Regra'], "")
    end

    if !(linha =~ /then/)
      linha = linha.gsub(regexs['='], "==")
    end

    linha = linha.downcase

    selinhas[contr3] = linha
    contr3 += 1
  end

  contr += 1
end

#-------------------------------------------------------- Tradução ---------------------------------------------------#

selinhas.each do |linha|
  #Encontra a última palavra de cada linha e coloca aspas duplas
  if !(linha =~ regexs['then']) and (linha =~ regexs['andesp'] or linha =~ regexs['ifesp'])
    regexs['ultpalavra'].match(linha)
    var = $&
    var2 = var.gsub(regexs['=esp'], "")
    linha = linha.gsub("#{var}", "= \"#{var2}\"")
  end

  #Remove o espaço em excesso que está no início das linhas
  if linha =~ regexs['ifesp'] or linha =~ regexs['andesp'] or linha =~ regexs['thenesp']
    linha = linha.gsub(regexs['espif'], "if").gsub(regexs['espand'], "and").gsub(regexs['espthen'], "then")
  end

  #Encontra as variáveis e substitui os espaços entre elas pelo underline
  if linha =~ regexs['ifesp'] or linha =~ regexs['andesp'] or linha =~ regexs['thenesp']
    init_variavel = $'

    if init_variavel =~ /\s*=/
      variavel = $`
      variavelmod = variavel.gsub(/\s/, "_")
    end
  end

  #Encontra o valor na linha do then e coloca-o entre aspas duplas
  if linha =~ regexs['then']
    regexs['=esp'].match(linha)
    init_valor = $'

    if init_valor =~ /\send/
      valor = $`
      valormod = valor.gsub("#{valor}", "\"#{valor}\"")
    end
  end

  #Altera as variáveis e valores encontrados anteriormente
  linha = linha.gsub(/#{variavel}/, "#{variavelmod}").gsub(/#{valor}/, "#{valormod}")

  setraduzido[contr4] = linha
  contr4 += 1
end

#Pega as veriaveis, guarda cada uma delas em uma posição do vetor sefinal e cria a instancia das variaveis
setraduzido.each do |linha|
  if !(linha == "")
    variavel = regexs['variavel'].match(linha).to_s
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

puts sefinal

#fecha os arquivos
rules.close

#Cria o arquivo
file = File.new("filmes.rb", "w")

#Grava o Sistema Especialista em ruby no arquivo
sefinal.each do |linhat|
  file.puts "#{linhat}"
end
