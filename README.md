<h2>Observações sobre o projeto:</h2>
<h2>Tecnologias:</h2>
  <ul>
  <li>Ele foi feito em Rails por conta tanto do meu domínio na linguagem e do framework, quanto pelo próprio contexto da vaga.</li>
  <li>Foi usado postgres por ser um banco de dados relacional mais performático. </li>
  </ul>

<h2>Solução dos problemas:</h2>
  <ul>
  <li>- Para a construção das APIS utilizei o Grape (https://github.com/ruby-grape/grape), que desloca a criação das APIs do controller. </li>
  <li>- Para resolução efetiva do problema do modelo dos dados, achei que se encaixava muito bem com uma implementação de grafos, já com o calculo do caminho mínimo de Dijkstra, para depois calcular o custo. Para isso, usei a gem RGL (https://github.com/monora/rgl). </li>
  <li>- Usei índices nas colunas das tabelas pra resolver o problemas de performance no acesso ao banco. </li>
  <li>- Também usei apenas uma tabela pois não vi a necessidade de modelar os dados de outra forma. </li>
  <li>- Usei RSpec para os testes. </li>
  </ul>

<h2>Acesso:</h2>
<ul>
<li>Exemplo de acesso para cadastro dos destinos:
  /distance?origin=A&destination=C&distance=100</li>
<li>Exemplo de acesso para saber o custo do frete:
  /cost?origin=A&destination=C&weight=5</li>
</ul>