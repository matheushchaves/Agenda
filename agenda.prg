#include "Fivewin.ch" // Biblioteca do Fivewin
#include "xbrowse.ch" // Biblioteca do xBrowse *
#Define CLR_SKY    nRGB( 202, 228, 255 ) // Define * de uma cor
Function main()
   Local aEstrutura:={} // Inicializa��o Para Vetor ou Matriz

   SetGetColorFocus( CLR_SKY )
   // Padr�o para Cor do Fundo das Caixas de Texto , Ou Get

   SET DELE ON  // Ativa o Delete dos Arquivos
   SET CENT ON  // Ativa o Seculo com 4 Digitos
   SET DATE BRIT // Ativa o Modelo de Data Britanico , 01/12/1994
   SET EPOCH TO 1980 // Ativa a Epoca para 1980 , caso precise fazer calculos de data , o seculo vai ser noventa , corrige o bug do milenio
   SET MULTIPLE ON   //  comando, permite executar v�rias inst�ncias do mesmo EXE FiveWin. Use-o para que seus usu�rios executar o aplicativo m�ltiplas vezes de uma s� vez.
   *
   SET 3DLOOK ON    // Visual 3d no tema do programa
   SET SOFTSEEK OFF // Pesquisa sensivel Desativada
   SET CONFIRM ON   // Requer do Usuario presionar enter
   sethandlecount(250) // Quantidade de Arquivos que o Programa pode abrir
   SetBalloon( .T. )  // Fun�ao para Mudar o Formato do ToolTip

   *
   /*
   Carregando as Dll's do Programa , essas
   Dlls s�o necessarias para o bom funcionamento
   e compatibilidade do sistema
   */
   
   hBorland := LoadLibrary( "bwcc32.dll" )
   hBorland := LoadLibrary( "prev32.dll" )
   hBorland := LoadLibrary( "screen32.dll")
   
   BWCCRegister( GetResources( ) )
   /* Fim do Carregamento */

   /*Setando o RDD padr�o do programa , Lembrar que tambem muda no projeto */
   REQUEST DBFCDX
   RDDSETDEFAULT("DBFCDX")
   /*Fim*/


   /*Criando estrutura do Dbf e Indexando*/
   AAdd(aEstrutura,{"CODIGO","C",4,0})
   AAdd(aEstrutura,{"NOME","C",80,0})
   AAdd(aEstrutura,{"IDADE","N",2,0})
   AAdd(aEstrutura,{"TELEFONE","C",9,0})

   /* Lembrando os tipos de campos existentes no Dbf
   C -> Caractere
   N -> Numero
   L -> Logico
   D -> Date
   Tambem os Tamanhos dos campos e seus decimais caso seja um numerico
   */


   if ! File("Agenda.dbf")
      DBCreate("agenda.dbf",aEstrutura) // Comando para criar tabela com a estrutura acima
   endif

   if ! File("Agenda.cdx")
      use agenda exclusive
      if !NetErr()
         pack
         index on codigo      tag agenda1 to agenda &&   Indexando os campos
         index on UPPER(nome) tag agenda2 to agenda &&   N�o � necessario indexar todos os campos
         index on idade       tag agenda3 to agenda &&   somente aquele que voce vai usar para pesquisa
         index on telefone    tag agenda4 to agenda &&   exite varias maneiras de usar indices de pesquisa
      endif
   endif
   Close data && Close data � fechar todos os bancos de dados abertos
   /*
   Todo Objeto tem Prompriedade e Metodos **
   */


   /*
   O Menu Funciona Como Uma Arvore
   Ele primeiro precisa instanciar o Objeto
   Depois somente precisamos declarar seus ramos
   o primeiro foi o agenda , seguido de incluir e consultar , sair entao fechei o ramo agenda
   o outro foi o utilitarios e assim por diante
   */


   Menu oMenu
   Menuitem "Agenda"
   menu
   menuitem "Incluir"  action Editar(.t.) // Fun��o de Editar com a Op�ao de Incluir e Alterar
   menuitem "Consultar" action Consulta_Agenda() // Fun�ao de Consulta
   SEPARATOR
   MENUITEM "Sair" Action oWNd:end() Message "Sair do Sistema" // Saida do Sistema
   endmenu
   Menuitem "Utilit�rios" // Calculadora e Ip
   menu
   menuitem "Calculadora" Action WinExec("calc.exe",0) message "Abre a Calculadora do Windows" // Executando a Calculadora do Windows
   //menuitem "Mostra o Ip" Action msginfo( VerIp(),"Ip do Computador") message "Informa o Nr� do Ip" // Fun�ao que retorna o Nr do Ip
   endmenu
   Menuitem "Sobre" action MsgAbout("Sobre o Progrma "," Programa do Curso de Fivewin ") // Tipo de Mensagem do fivewin
   endmenu


   dEFINE ICON oico file	  "agenda.ico" // Define Icone para o Programa
   Define Brush oBrush file "brush.bmp"   // Define Brush para o Programa

   /* Defini�ao da Janela Principal do Programa
   Nela Contem , 1� o Objeto ,2� o Titulo , 3� o Brush que a janela vai ter
   4� o Menu que a janela vai ter , 5� o Icone do Programa
   */
   Define Window oWnd Title "Agenda Simples de Contatos" Brush oBrush Menu oMenu   ICON OICO

   /* Defini�ao da barra de botao da Janela
   Nela Contem
   1� Objeto , Lembrando que pode ser qualquer nome
   2� 3d , visual da barra tambem pode ser em 3d
   3� Size , referente ao tamanho da barra , lembrando caso nao informe ele vai assumir um tamanho padrao
   4� Of __  , Aqui voce informa qual � a janela que essa barra vai estar
   5� 2010 , Estilo visual , tambem pode ser 2007 , ou nao ter nenhuma
   6� Left , Posi�ao da barra de botoes , que pode ser , Em Cima (TOP), Em Baixo (BOTTOM) , A Direita (RIGHT)
   * Existe outras coisas que podemos colocar na barra , para mais inform�ao esntre na pasta include , c:\fwh*\include
   */
   DEFINE BUTTONBAR oBar 3D SIZE 60,70 OF oWnd 2010 LEFT

   /* Defini��o do Botao da Barra de botoes
   1� oBtn01   - Objeto do Botao
   2� File ___ - Local onde Contem a Imagem(Bitmap)
   3� Of ____  - Objeto da barra onde o bot�o pertence
   4� Action   - Fun�ao ou Comando que vai ser executado ao clicar no botao
   5� Tootip   - Bal�o ou Box de Informa�ao , Muda de Acordo com a fun�ao SetBalloon( .T. ) , se passar .t. -> Balao , .f. -> Box
   6� Message  - Mensagem que vai ser exibida na barra da window
   7� noborder - Sem Borda ao redor do Botao
   8� Prompt   - Texto do Bot�o
   * Existe outras coisas que podemos colocar na barra , para mais inform�ao esntre na pasta include , c:\fwh*\include
   */

   Define button obtn01 file "const.bmp" of obar;
    action Consulta_Agenda() tooltip "Consulta contatos cadastrados" ;
    message "Consulta de Contatos"  noborder  prompt  "Consulta contatos"

   Define button obtn02 file "exit.bmp" of obar;
    action oWnd:End() tooltip "Sair do Programa" ;
    message "Sair do Programa"  noborder  prompt  "Sair"

   /*
   Comando que cria uma barra de bot�o na janela
   1� Of - Objeto da Janela que a barra de mensagem vai existir
   2� to - Texto da Barra de Bot�o
   3� Time - Exibir um pequeno relogio digital na barra
   4� Date - aparecer pequena data na barra
   5� Keyboard - Aparecer status do teclado = Insert , CapsLock , ScrollLock
   6� 2010 , Estilo visual , tambem pode ser 2007 , ou nao ter nenhuma
   * Existe outras coisas que podemos colocar na barra , para mais inform�ao esntre na pasta include , c:\fwh*\include
   */
   Set Message Of oWnd TO "Acesse Fontefivewin.wordpress.com e Descubra como Aprender Mais" TIME DATE KEYBOARD  2010

   /* Activate � o Comando para Ativar a Tela depois de contruir tudo que vai pertencar a ela
   1� Window - Objeto que vai ser "ativo"
   2� Maximized - Tela aberta Maximizada , pode ser minimizada , ou normal
   3� Valid - Processo de teste quando a janela for fechada

   */

   /*
   MsgYesNo -> Mensagem padrao do fivewin que permite criar uma pergunta rapida para o usuario
   que retorna .t. para o Click no Sim e .f. para N�o
   */

   Activate Window oWnd MAXIMIZED valid MsgYesNo("Deseja Realmente Sair do Sistema?","Pergunta") &&*


Function Consulta_Agenda()
   /* Aten��o
   Os comando contidos aqui nao s�o todos
   os padroes mas os mais simples de
   serem usados caso queira entender
   mais consulte a pasta samples ,
   c:\fwh*\samples e a pasta include
   c:\fwh*\include que contem as estruturas
   dos comandos e das classes
   */


   /*
   Maneira de Abrir tabela sem sofrer danos de programa�ao*
   fun�ao select retorna 0 caso o alias nao esteja aberto
   assim o if testa se ele esta aberto , se estiver a select
   retorna diferente de 0
   se ele for 0 entao eu abro a tabela
   - Comando Use
   1� agenda - Nome do arquivo (ou caminho+nome)
   2� age - apelido da tabela
   3� shared - tabela aberta em modo compartilhado , tambem existe o modo exclusivo
   4� New - Nova Area para abrir a tabela ,caso nao use o comando quando for usar outra ele fecha a anterior
   - NetErr()
   Essa Fun�ao verfica se houve algum impedimento na abertura da tabela, se sim
   ela retorna true , assim a codi�ao � satisfeita e exibimos a mensagem
   fechamos as tabelas abertas e retornamos da fun�ao
   - Set Index to Agenda - abre o cdx criado anteriormente
   * caso queira colocar uma pasta padr�o para abertura de dados Use o Set Default to "c:\CaminhoDaPasta"
   */

   if Select("age")=0
      Use Agenda alias age shared new
      if NetErr()
         MsgInfo("Tabala Aberta em Modo Exclusivo","Informa�ao")
         Close Data
         Return .t.
      endif
      set index to agenda
   endif

   /*
   Define Fonte para o Browse
   1� oFontBrw - Objeto que vai receber as propriedade da fonte
   2� Name -  Nome da fonte
   3� Size - Tamanho da fonte = largura por altura
   */
   Define Font oFontBrw Name "Times New Roman" Size 9,15

   /*
   Define a Dialog
   1� Objeto - Objeto que vai receber as propriedade da fonte
   2� Resource - Nome do Local no Recurso (RES) onde essa dialog esta
   3� Title    - Titulo da Janela

   */

   Define Dialog oDlg Resource "AGEND1" Title "Consulta de Contatos"

   /*
   Browse de Dados
   - Esta � a Classe mais poderosa do fivewin , com ela tem como voce fazer muuuita coisa ,
   aqui temos a sintaxe mais simples que ela pode ser usada

   1� oBrw - Objeto do Browse
   2� id   - Nr do Browse no recurso citado acima
   3� Of   - Objeto da Dialog a Qual o Browse Pertence
   4� Font - Objeto da Fonte do Browse , isso foi definido acima
   5� Colors - Cores Padr�o para a Letra e o Fundo do Browse
   */


   REDEFINE XBROWSE oBrw ID 361 OF oDlg Font oFontBrw  COLORS CLR_BLACK,CLR_SKY

   /*
   Colunas
   1� oCol - Objeto da Coluna , caso queira fazer alguma modifica�ao Futura**
   2� oBrw - Objeto do Browse que a coluna pertence
   3� Data - Campo do Dbf ou da Matriz que vai ser exibido no Browse
   4� Size - Tamanho da coluna no Browse
   5� RIGHT - Ajuste de TEXTO Do Cabe�alho e do Conteudo de cada linha , Pode ser LEFT ou CENTER Tambem
   6� Hearder - Nome do Cabe�alho
   * 7� COLOR - Aqui fica a cor daquela coluna tanto o texto , como o fundo do texto
   */

   ADD COLUMN oCol TO XBROWSE oBrw  DATA age->codigo   SIZE 80   RIGHT  HEADER "Codigo"
   ADD COLUMN oCo2 TO XBROWSE oBrw  DATA age->nome     SIZE 310  LEFT   HEADER "Nome"
   ADD COLUMN oCo3 TO XBROWSE oBrw  DATA age->idade    SIZE 55   CENTER HEADER "Idade"   COLOR CLR_BLACK, CLR_HGRAY
   ADD COLUMN oCo4 TO XBROWSE oBrw  DATA age->telefone SIZE 100  RIGHT  HEADER "Telefone"

   * oBrw:nMarqueeStyle - Recebe o Estilo que a linha selecionada vai ter , veja mais em c:\fwh*\include\xbrowse.ch
   oBrw:nMarqueeStyle       := MARQSTYLE_HIGHLROW

   * oBrw:nColDividerStyle - Recebe o Estilo Que a linha que passa para dividir a coluna vai ter , veja mais em c:\fwh*\include\xbrowse.ch
   oBrw:nColDividerStyle    := LINESTYLE_DARKGRAY

   * oBrw:nRowDividerStyle - Recebe o Estilo Que a linha que passa para dividir a linha vai ter , veja mais em c:\fwh*\include\xbrowse.ch
   oBrw:nRowDividerStyle    := LINESTYLE_DARKGRAY

   * oBrw:lRecordSelector - Recebe o valor de .t. e .f. para criar uma coluna que mostra a linha selecionada , veja mais em c:\fwh*\sources\classes\xbrowse.prg
   oBrw:lRecordSelector     := .F.

   * oBrw:lColDividerComplete - Recebe o valor de .t. e .f. para Dividir todas as Linhas com a Coluna , veja mais em c:\fwh*\sources\classes\xbrowse.prg
   oBrw:lColDividerComplete := .t.

   * oBrw:lFastEdit - Recebe o valor de .t. e .f. para Mudar as Posi�oes da Coluna em tempo de execu��o , veja mais em c:\fwh*\sources\classes\xbrowse.prg
   oBrw:lFastEdit           := .t.

   /*
   Botao Sem Imagem
   1� bt1 - Objeto do Bot�o
   2� Id - Numero Identificador do Bot�o no Recurso
   3� Of - Objeto da Dialog que o Bot�o Pertence
   4� Action - A��o que o bot�o vai executar , na caso esta fazendo duas a�oes
   5� Prompt - Texto do Bot�o
   */
   REDEFINE BUTTON bt1 ID 20  OF oDlg ACTION ( pesq_codigo()  , oBrw:Refresh()) Prompt "&1.Codigo"
   REDEFINE BUTTON bt2 ID 21  OF oDlg ACTION ( pesq_nome()    , oBrw:Refresh()) Prompt "&2.Nome"
   REDEFINE BUTTON bt3 ID 22  OF oDlg ACTION ( pesq_telefone(), oBrw:Refresh()) Prompt "&3.Telefone"
   REDEFINE BUTTON bt4 ID 23  OF oDlg ACTION ( pesq_idade()   , oBrw:Refresh()) Prompt "&4.Idade"

   /*
   Botao Com Bitmap
   1� btnbmp01 - Objeto do Bot�o
   2� Id - Numero Identificador do Recurso
   3� Of - Objeto da Dialog onde ele pertence
   4� Action - A�ao que ele vai executar
   5� Bitmap - Local onde a imagem (bitmap) vai estar
   6� Prompt - Texto do Bot�o
   7� TEXTBOTTOM - Posi��o onde o texto vai ficar , pode ser tambem TEXTTOP , TEXTRIGHT, TEXTLEFT
   8� ADJUST - Ajusta texto e Imagem no Bot�o
   9� When - Condi��o de quando , quando a condi�ao retornar verdade ele habilita quando for falso ele desabilita
   */
   REDEFINE BUTTONBMP btnbmp01 ID 10 OF oDlg ACTION ( Editar(.f.) , oBrw:Refresh() ) BITMAP "alterar.bmp" PROMPT "&Alterar" TEXTBOTTOM ADJUST  when !age->(eof())
   REDEFINE BUTTONBMP btnbmp02 ID 11 OF oDlg ACTION ( Excluir()   , oBrw:Refresh() )  BITMAP "excluir.bmp" PROMPT "&Excluir" TEXTBOTTOM ADJUST
   REDEFINE BUTTONBMP btnbmp03 ID 12 OF oDlg ACTION ( Imprimi()   , oBrw:Refresh() )  BITMAP "imprimi.bmp" PROMPT "&Imprimir" TEXTBOTTOM ADJUST
   REDEFINE BUTTONBMP btnbmp04 ID 13 OF oDlg ACTION oDlg:End()  BITMAP "sair.bmp"    PROMPT "&Retornar" TEXTBOTTOM ADJUST

   /*
   Activate - Constroi a Dialog Com As Informa�oes Acima
   1� oDlg  - Objeto
   2� Posi�ao - Local onde a janela deve abrir sempre
   *Lembrando que essas op�oes podem varias
   para saber mais informa�oes consultE em
   c:\fwh*\include\fivewin.ch ou c:\fwh*\include\dialogs.ch

   */

   Activate Dialog oDlg Center

   Close Data
   /*
   Fun�ao Editar com um parametro lInclui - Tipo Logico
   A Fun��o Editar tanto � usada para incluir como para alterar
   atraves do parametro lInclui posso saber se inclui e altera e
   usar uma unica fun�ao para fazer esses 2 processos

   */


Function Editar(lInclui)
   /*
   Abertura de Tabela
   */
   If Select("age")=0
      Use Agenda alias age shared new
      if NetErr()
         MsgInfo("Tabala Aberta em Modo Exclusivo","Informa�ao")
         Close Data
         Return .t.
      endif
      set index to agenda
   endif
   /**/

   /* Uso o La�o While para fazer sempre Pois caso voce come�e a Incluir
   ele vai sempre gerando a tela sem precisar abrir varias vezes
   */
   While .t.
      lsalva:=.f. // Variavel de COntrole do Bot�o confirmar e Retornar
      Select age  // Seleciono tabela agenda pelo apelido
      vcodigo:=age->codigo // Pego o Codigo da tabela e atribuo na variavel
      if lInclui     && Se For Incluir Ele Gera Um Novo Codigo
         go bottom   && Colocando a Tabela para o Ultimo Registro
         && e Atravez desse processo do strzero ele gera +1
         && para o ultimo codigo, assim ele cria um novo codigo
         vcodigo:= strzero( val( age->codigo ) +1 , len(age->codigo),0)
         && o StrZero recebe ( ValorNumero , TamanhoNumero,DecimalNumerico)
         && e Retorna Uma string dos numeros adicionados com o 0(zero)
         && assim eu converto o campo age->codigo que � caractere para valor
         && atraves do val e somo +1 , o tamanho do campo tenho atraves da fun�ao len
         && e os decimais passo 0 porque meus codigo nao s�o decimais
         skip     && Passo para o Proximo , Assim como ele ja esta no Ultimo Registro
         && Ele Limpa todos os campos das variaveis
      endif
      && Entao quando o usuario for incluir ele gerou o codigo e limpou as variaveis
      && ja Se Ele for alterar ele vai pegar o codigo nome idade e telefone exatemente
      && como esta na linha selecionada la no browse
      vnome:=age->nome
      vidade:=age->idade
      vtelefone:=age->telefone

      && Ja Vimos a Dialog Anteriormente ,Agora so tem uma condi�ao a mais
      && no titulo tem a fun�ao If que funciona  da seguinte maneira
      && if ( condi�ao, verdade, falso)
         && entao eu vejo se linclui � Verdade .t. caso seja ele retorna Incluir e concatena
         && com o resto que � mais contato
         && Se lInclui for Falso significa que ele esta alterando , pego o texto alterar e contateno com Contato


         Define Dialog oDlg1 Resource "AGEND2" TITLE if (lInclui,"Incluir","Alterar")+" Contato"

         /* Get - � Uma Caixa de Texto
         1� ocodigo - Objeto do Get
         2� vcodigo - variavel que recebe o conteudo digitado ,na caso do get
         3� pict    - Mascara para moldar a entrada de texto
         4� id      - Identificador no Recurso da Dialog Citada acima "AGEND2"
         5� Of      - Dialog a qual o get pertence
         6� Valid   - Condi�ao de Teste para Sair para o Proximo campo ou controle
         */


         Redefine Get ocodigo var vcodigo pict "9999" id 15 of oDlg1 valid !Empty(vcodigo)
         redefine get onome   var vnome               id 16 of oDlg1 valid !Empty(vnome)
         redefine get oidade  var vidade   pict "99"   id 17 of oDlg1 valid (vidade>0)
         redefine get otelefone var vtelefone pict "9999-9999" id 18 of oDlg1

         /*
         Bot�o Simples
         * o Action dele controla a variavel lsalva para saber se o usuario confirmou ou n�o o codigo
         */

         REDEFINE BUTTONBMP obnt01 ID 19 OF oDlg1 ACTION (lsalva:=.t.,oDlg1:End()) PROMPT "&Confirmar"
         REDEFINE BUTTONBMP obnt02 ID 20 OF oDlg1 ACTION (lsalva:=.f.,oDlg1:End()) PROMPT "&Retornar"

         activate dialog oDlg1 center



         if lsalva // Se Confirmar
            Select Age // Seleciona o Banco
            if lInclui // Se For inclus�o
               Append Blank // Abre o Novo Registro
            endif  // Caso nao seja inclusao ele vai dar replace no registro atual
            if RLOCK()  // Trava a tabela , retorna true caso Funcione
               /* Replace
               Usado para gravar na tabela Informa�oes
               */
               replace codigo with vcodigo
               replace nome   with vnome
               replace idade  with vidade
               replace telefone with vtelefone
            endif
            commit // Commit , grava do arquivo o que tem na memoria
         else // Caso nao queira salvar
            exit // Ele para de repetir o La�o
         endif
         if lInclui=.f.   // Caso ele queira salvar e esteja alterando (incluir � .f.) entao saia do la�o de repeti�ao
            Exit
         endif
      end
      Select Age && Selecione a Tabela
      Go Top     && Va Ao Topo

   Function Excluir()
      && Fun�ao Para Excluir Um Registro
      &&

      Select age
      if MsgYesNo("Deseja Excluir esse contato?","Pergunta") // MsgYesNo - Faz uma pergunta , Ja Visto + Acima
         if RLOCK() // TRAVA Tabela
            delete // Deleta
            unlock // Destrava
            commit // Commita
         endif
         select age &&   Vai ao Topo
         go top      &&
      endif

   Function pesq_codigo()
      /*
      Pesquisa de Codigo

      */
      Local vcodigo:=space(len(age->codigo))
      nRegistro:= RecNo()
      && Essa Pesquisa permite capturar uma informa�ao com uma caixa padrao do fivewin
      && MsgGet ( Titulo , Texto , Variavel que vai atribuir , Bitmap )
      If MsgGet("Informe o Codigo","Codigo do Contato:",@vcodigo,"pesquisa.bmp")

         && Assim eu converto caso o usuario digite 5 para 0005
         vcodigo:=strzero(val(vcodigo),len(age->codigo),0)
         Select Age
         set order to 1 // Seto o Indice da pesquisa
         seek vcodigo   // Pesquiso o Codigo
         if eof()       // Fim do Arquivo isso � a fun�ao Eof , verifica se � o fim do arquivo
            // Se For Fim do Arquivo Exibo uma mensagem
            // e Retorno ao Registro anterior capturado na entrada da Fun�ao
            MsgInfo("Codigo n�o Encontrado!!!","Informa��o")
            go nRegistro
            return .t.
         endif
         return .t.
      endif



   Function pesq_nome()
      Local vNome:=space(len(age->nome))
      nRegistro:= RecNo()
      If MsgGet("Informe o Nome","Nome do Contato:",@vnome,"pesquisa.bmp")
         Select Age                 && Esta pesquisa � Semelhante as outras
         set order to 2             && a Diferen�a que o Indice esta criado maiusculo
         seek ALLTRIM(UPPER(VNOME)) && e entao eu converto a string para maiusculo assim nao tem problema com a pesquisa
         if eof()
            MsgInfo("Nome n�o Encontrado!!!","Informa��o")
            go nRegistro
            return .t.
         endif
         return .t.
      endif

   Function pesq_telefone()
      local vtelefone:=space(len(age->telefone))
      nRegistro:= RecNo()
      If MsgGet("Informe o Telefone","Telefone do Contato:",@vtelefone,"pesquisa.bmp")
         Select Age
         set order to 4
         seek vtelefone
         if eof()
            MsgInfo("Telefone n�o Encontrado!!!","Informa��o")
            go nRegistro
            return .t.
         endif
         return .t.
      endif
   Function pesq_idade()
      local vidade:=0
      nRegistro:= RecNo()
      If MsgGet("Informe o Idade","Idade do Contato:",@vIdade,"pesquisa.bmp")
         Select Age
         set order to 3
         seek vidade
         if eof()
            MsgInfo("Idade n�o Encontrado!!!","Informa��o")
            go nRegistro
            return .t.
         endif
         return .t.
      endif


   Function FuncImp()
      Local oradio1,oDlgimp,lsave:=.f.,oprn2
      public TipoRel:="M"
      nordimp=1
      Sysrefresh()
      retornoimp=.t.
      IF getprintdc()==0
         retornoimp=.f.
         return retornoimp
      endif
      printer oprn
      tipimp:=oprn:nLogPixelx()
      if tipimp<300
         TipoRel:="M"
      elseif tipimp>=299
         TipoRel:="J"
      endif
      *? tipimp
      * if msgyesno("Confirma impressora escolhida para iniciar impress�o !!!","Pergunta")
         retornoimp=.t.
      * else
         *   retornoimp=.f.
      * endif
      return retornoimp
   Function Resolucao_Impressora()
      Public nTam,resolucao_Impressora
      resolucao_Impressora=oprn:nlogpixelx()
      nTam   :=18
      if resolucao_Impressora>=100  // Matricial
         nTam:=08
      endif
      if resolucao_Impressora>=300  // Jato de Tinta
         ntam:=18
      endif
      if resolucao_Impressora>=600  // Termica
         ntam:=35
      endif
      if resolucao_Impressora>=900  // TERMICA SUPER FAST
         ntam:=52
      endif
      Return .t.


   Function Imprimi()

      if funcimp()=.f.
         //CLOSE DATA
         retu .t.
      endif
      cTitulo:="Lista de Contatos"
      PRINT oPrn NAME cTitulo PREVIEW

      nTam   :=18
      nTamRel:=92
      resolucao_impressora()

      nTamPag:=66
      tlin   :=62
      npag:=0
      inicio:=0
      DEFINE FONT oFontic NAME "Britannic Bold" size ntam+3,-12 OF oPrn
      DEFINE FONT oFonti1 NAME "Times New Roman" size ntam+1,-12 of oPrn
      DEFINE FONT oFonti2 NAME "Arial" size ntam,-12 OF oPrn
      DEFINE FONT oFonti3 NAME "Courier New" size ntam,-12 OF oPrn

      *
      *
      if empty( oprn:hdc )
         MsgStop( "Impressora n�o est� pronta !!!" )
         return nil
      endif

      Select age
      Set Order to 2
      go top
      While !Eof()
         If tlin > 60
            npag ++
            if inicio>0
               endpage
            endif
            page
            oPrn:SetFont(oFontic)
            oPrn:CharSay(01,002,"Curso Fivewin de Matheus Farias")
            oPrn:CharSay(02,002,"Fivewin For Harbour")
            oPrn:SetFont(oFonti1)
            oPrn:CharSay(01,055,"P�gina:"+Str(nPag,4),"D")
            oPrn:CharSay(02,055,"Data:"+Dtoc(Date()),"D")
            oPrn:CharSay(03,002,"Agenda Simples Exemplo 1")
            oPrn:CharSay(04,002,cTitulo)

            tlin:=05
            oPrn:Charsay(tlin,01,replicate("-",120))
            tlin++
            oPrn:SetFont(oFonti3)
            oPrn:Charsay(tlin,02,"Codigo")
            oPrn:Charsay(tlin,12,"Nome")
            oPrn:Charsay(tlin,50,"Idade")
            oPrn:Charsay(tlin,80,"Telefone")
            tlin++
         endif
         oPrn:charsay(tlin,02,age->codigo)
         oPrn:charsay(tlin,13,age->nome)
         oPrn:charsay(tlin,51, transform( age->idade,"@R 99"))
         oprn:charsay(tlin,81,age->telefone)
         tlin++
         inicio++
         Select age
         Skip
      end
      oPrn:Charsay(tlin,01,replicate("-",120))
      tlin++
      oPrn:charsay(tlin,02,"Fontefivewin.wordpress.com.br")
      tlin++

      if inicio=0
         msginfo("N�o Existem informa��es para imprimir...","Aten��o")
         retu
      endif
      oprn:lprvmodal:=.T.
      endpage
      endprint
      oFontic:end()
      oFonti1:end()
      oFonti2:end()
      oFonti3:end()
      Select age
      Set Order to 1
      Go Top
      SysRefresh()
DLL32 FUNCTION BWCCRegister( hInst AS LONG ) AS WORD PASCAL LIB "BWCC32.DLL"
#pragma BEGINDUMP


#ifdef __cplusplus
extern "C" {
#endif
void _HUGE( void )
{
}
#ifdef __cplusplus
}
#endif

#pragma ENDDUMP