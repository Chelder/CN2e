# encoding: UTF-8

class TraducaoSe
  # Remove as letras acentuadas
  def remover_acentos(texto)
    texto = texto.gsub(/[á|à|ã|â]/, 'a'.force_encoding("UTF-8")).gsub(/(é|è|ê)/, 'e').gsub(/(í|ì|î)/, 'i').gsub(/(ó|ò|õ|ô)/, 'o').gsub(/(ú|ù|û)/, 'u')
    texto = texto.gsub(/(Á|À|Ã|Â)/, 'A').gsub(/(É|È|Ê)/, 'E').gsub(/(Í|Ì|Î)/, 'I').gsub(/(Ó|Ò|Õ|Ô)/, 'O').gsub(/(Ú|Ù|Û)/, 'U')
    texto = texto.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    return texto
  end

  #Remove caracteres especiais
  def remover_especial(texto)
    texto = texto.gsub(/\(+/, "").gsub(/\[+/, "").gsub(/\{+/, "")
    texto = texto.gsub(/\)+/, "").gsub(/\]+/, "").gsub(/\}+/, "")
    return texto
  end

  #Encontra a última palavra de cada linha e coloca aspas duplas
  def ultima_palavra(texto)
    if !(linha =~ regexs['then']) and (linha =~ regexs['andesp'] or linha =~ regexs['ifesp'])
      regexs['ultpalavra'].match(linha)
      var = $&
      var2 = var.gsub(regexs['=esp'], "")
      linha = linha.gsub("#{var}", "= \"#{var2}\"")
    end
  end
end

