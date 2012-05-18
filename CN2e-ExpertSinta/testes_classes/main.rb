require "../testes_classes/sentidos"
require "../testes_classes/gestos"

class Main
  acao = Gestos.new
  acao2 = Sentidos.new

  acao.andar
  acao2.falar

  acao.correr
  acao2.ouvir
end