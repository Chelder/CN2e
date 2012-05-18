# encoding: UTF-8

class TraducaoSe
  # Remove as letras acentuadas
  #
  # Exemplo:
  #  String.remover_acentos('texto está com acentuação') ==> 'texto esta com acentuacao'
  # @param texto [Object]
  def remover_acentos(texto)
    texto = texto.gsub(/[á|à|ã|â]/, 'a'.force_encoding("UTF-8")).gsub(/(é|è|ê)/, 'e').gsub(/(í|ì|î)/, 'i').gsub(/(ó|ò|õ|ô)/, 'o').gsub(/(ú|ù|û)/, 'u')
    texto = texto.gsub(/(Á|À|Ã|Â)/, 'A').gsub(/(É|È|Ê)/, 'E').gsub(/(Í|Ì|Î)/, 'I').gsub(/(Ó|Ò|Õ|Ô)/, 'O').gsub(/(Ú|Ù|Û)/, 'U')
    texto = texto.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    return texto
  end
end

