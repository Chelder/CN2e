#programa leitura
require 'digest/sha1'
require 'time'


linhasfile    = Array.new
linhas_assinatura = Array.new
linhas_tempo  = Array.new
shalinhasfile = Array.new
vetfinal      = Array.new


  puts "Digite o nome do arquivo CSV "   
  nomearquivo_asc = gets.chomp
  #contadorfilerb = 1
  #Dir.chdir('/Users/rei/Downloads')

  arquivoorigem_asc = File.new(nomearquivo_asc + ".txt","r")
  entrou = false
  lin = 0 #linha 0 = cabecalho, linha 1 = linha em branco
  lin_signature = 0
  while not arquivoorigem_asc.eof do
    linhasfile[lin] = arquivoorigem_asc.gets.chomp.to_s
    puts lin.to_s + ' ' + linhasfile[lin]
    

    sleep(0.01)
    if (linhasfile[lin] == '-----BEGIN PGP SIGNATURE-----') then
       entrou = true
     end
     if entrou == true then
       while not arquivoorigem_asc.eof do
         linhas_assinatura[lin_signature] = arquivoorigem_asc.gets.chomp.to_s
         puts 'entrou ' + lin_signature.to_s + ' ' + linhas_assinatura[lin_signature]
         sleep(0.1)
         lin_signature = lin_signature + 1
       end
     end

     lin = lin + 1
  end
  puts linhas_assinatura 
  puts
  puts Digest::SHA1.hexdigest linhas_assinatura.to_s
  
   
 