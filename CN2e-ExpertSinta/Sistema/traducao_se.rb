# encoding: UTF-8

class TraducaoSe

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
  def ultima_palavra(linha)
    if !(linha =~ $regexs['then']) and (linha =~ $regexs['andesp'] or linha =~ $regexs['ifesp'])
      $regexs['ultpalavra'].match(linha)
      var = $&
      var2 = var.gsub($regexs['=esp'], "")
      linha = linha.gsub("#{var}", "= \"#{var2}\"")
    end

    return linha
  end

  #Remove o espaço em excesso que está no início das linhas
  def remove_espaco_init(linha)
    if linha =~ $regexs['ifesp'] or linha =~ $regexs['andesp'] or linha =~ $regexs['thenesp']
      linha = linha.gsub($regexs['espif'], "if").gsub($regexs['espand'], "and").gsub($regexs['espthen'], "then")
    end

    return linha
  end

  #Encontra as variáveis e substitui os espaços entre elas pelo underline
  def altera_variavel(linha)
    if linha =~ $regexs['ifesp'] or linha =~ $regexs['andesp'] or linha =~ $regexs['thenesp']
      init_variavel = $'

      if init_variavel =~ /\s*=/
        variavel = $`
        variavelmod = variavel.gsub(/\s/, "_")
      end
    end

    return linha
  end

  #Encontra o valor na linha do then e coloca-o entre aspas duplas
  def aspas_valor(linha)
    if linha =~ $regexs['then']
      $regexs['=esp'].match(linha)
      init_valor = $'

      if init_valor =~ /\send/
        valor = $`
        valormod = valor.gsub("#{valor}", "\"#{valor}\"")
      end
    end

    return linha
  end
end

