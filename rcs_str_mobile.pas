unit rcs_str_mobile;

interface

uses System.SysUtils, FMX.Controls, System.Classes, FMX.StdCtrls, FMX.Dialogs,
     DateUtils,
     System.UITypes, System.IniFiles, System.IOUtils, FMX.Edit, FMX.Forms, FMX.Graphics;

     procedure ui_msg(sMsg:string;_Enter:boolean=True;_Form:TForm=nil;_Color:TColor=$FFFFFF;_Font:string='');
     function ifmsg(pergunta:string):word;
     function strTrans(stString:string; stOLD:string; stNEW:string): string;
     function pathZ(arq:string):string;
     function pathV(p:string;sub:string=''):string;
     function posC(pc:string;pc1:string):integer;
     function cs(var h:string;xSep:string='|'):string;
     function pegaSoNumeros(AValue:string):string;
     function zeDb(s:string):string;
     function testZ(cz:string):boolean;
     function strIgual(s1,s2:string):BOOLEAN;
     function clearAcentos(ca:string;_grafico:boolean):string;
     function picInt(p:string):integer;
     function replicate(rpChar:string;rpTmh:integer):string;
     function cleanEnd(t,c:string):string;
     function testaPasta(p:string):boolean;
     function sCh(s:string):PChar;
     function strZero(znivel: Integer; ztmh: integer): string;
     function sDb(s:string;l:boolean=False):string;
     function limpar_char_proibido(s:string;outros:array of string):string;
     function datDb(s:string):string;
     function dataNil(dn:string):boolean;
     function DDMMAAAA_to_AAAAMMDD( data:string ):string;
     function user_debug(m:string):boolean;
     function picF(stp:string):real;
     function eliminarDecimal(ed:real;fd:integer):string;
     function picture(ppvalor:array of real): string;
     function strRight(srtext:string;srtmh:integer): string;
     function pad(ptx:string;ptc:string;pth:integer):string;
     procedure ajusteArredondamento(var v:real);
     function formatarNome(n:string):string;
     function aaaammdd_to_ddmmaaaa(data:string):string;
     function formataCnpj(pcgccpf:string): string;
     function AnalizeCgc(cgccpf:string):boolean;
     procedure kNovoValor(sender:tobject;modo:word=2);
     procedure kNumeros(var Key:Char;modo:WORD=2);
     procedure kValor(sender:tobject;var Key:Char;modo:WORD=2;xExceto:string='');
     function kEnter(sender:tobject;modo:WORD=2;save:WORD=0;cor:tcolor=$0a0b0c):BOOLEAN;
     function kExit(sender:tobject;modo:WORD=2;data:word=0;hoje:word=0;cor:tcolor=$0a0b0c):BOOLEAN;
     procedure kKeyDown(F:tform; var Key:Word;CP:TObject=nil;MD:word=0);
     function kData(sender:tobject;modo,cNow:WORD;xExit:boolean=False):boolean;
     procedure kHoras(sender:tobject;var key:char;modo:WORD);
     procedure myskip(tela:tform;lado:integer;pulo:integer);
     function formatarData(sender:tobject):BOOLEAN;
     function formatarHoras(sender:tobject;modo:WORD):string;
     function formathora(hora:string):string;
     function formatData(sender:tobject;ctext:string): Boolean;
     function ParteDaData( ED: TDateTime; TED: Char ): Word;
     function ddmmaa_ddmmaaaa(data:string):string;
     function filtrarChar(ffchar:string):string;
     function IfThen(sCondicao:boolean;A,B:string):string;
     function check_q_decimal(cd:real):integer;
     function PicDb(s:string):string;
     function fiDataTime(s:string;db:boolean):variant;
     function fileTempor(t,e:string):string;
     function formatInt(i:string):string;
     function arquivoIsImagem(f:string):boolean;
     function iDb(s:string):string;
     function fDb(v:currency):string;
     function dDb(d:tdate):string;
     function temString(tn:string):boolean;
     function StrToBytes(text: string; codePage: Word): TBytes;
     function difHoras(inicio,fim:tdatetime;resume:boolean=false;resume2:boolean=false):string;
     procedure setMask(campo:tEdit;valor:Currency;ndfi:string='';espaco:real=0.5);
     procedure resolveRuaNumero(var s1,s2,s3:string);
     function sqlDate(nCampo,oTipo,vData:string):string;
     procedure extrairIds(s:string;var c,d:string);
     function CnpjCpfValido(n:string):BOOLEAN;
     function testCPFCGC(AValue:string): Integer;
     function diaDaSemana(d:string;feira:boolean=false):string;
     function faixa_de_comandas(nComanda:Integer):Boolean;
     function faixa_de_mesas(nMesa:Integer):Boolean;

var
   {$IFDEF ANDROID}
     plfStartStr:Integer=0;
     plfEndStr  :Integer=1;
   {$ENDIF}

   {$IFDEF WIN64}
     plfStartStr:Integer=1;
     plfEndStr  :Integer=0;
   {$ENDIF}

   {$IFDEF WIN32}
     plfStartStr:Integer=1;
     plfEndStr  :Integer=0;
   {$ENDIF}

   {$IFDEF IOS}
     plfStartStr:Integer=0;
     plfEndStr  :Integer=1;
   {$ENDIF}

   RCS_STATUSBAR:Boolean;
   RCS_ORIENTACAO:Boolean=False;
   RCS_ECONOMIA:Boolean=False;
   RCS_TAMANHO:integer=0;

   MESAS_INICIO:Integer = 1;
   MESAS_FINAL :Integer = 15;
   COMANDAS_INICIO:Integer = 501;
   COMANDAS_FINAL :Integer = 600;
   TIMER_SERVICOS:string ='';
   MESAS_LIVRES:boolean = False;
   RESTAURACAO_LOCAL:Boolean = False;
   COMANDA_NPED_RAPIDO:Boolean = False;

implementation

procedure ui_msg(sMsg:string;_Enter:boolean=True;_Form:TForm=nil;_Color:TColor=$FFFFFF;_Font:string='');
begin
     showmessage(sMsg);
end;

function ifmsg(pergunta:string):word;
var
   MR:TModalResult;
begin
     MessageDlg(pergunta,
                System.UITypes.TMsgDlgType.mtConfirmation,
               [System.UITypes.TMsgDlgBtn.mbYes,System.UITypes.TMsgDlgBtn.mbNo],
                0,
                procedure(const AResult: TModalResult)
                begin
                     MR:=AResult;
                end);

     while MR = mrNone do
           Application.ProcessMessages;

     if MR = mrYes then
        result:=1
     else
        result:=2;
end;

function strTrans(stString:string; stOLD:string; stNEW:string): string;
begin
     result:=stringreplace(stString,stOLD,stNEW,[rfReplaceAll]);
end;

function pathZ(arq:string):string;
begin
     result:=pathv(TPath.GetDocumentsPath + PathDelim + arq);
end;

function pathV(p:string;sub:string=''):string;
var
   d:string;
begin
     p:=p + sub;
     //p:=strTrans(p,'/','\');

     d:=PathDelim + PathDelim;

     while posc(p,d) > 0 do
           p:=strTrans(p,d,PathDelim);

     result:=p;
end;

function posC(pc:string;pc1:string):integer;
var
   tm,
   i:integer;
begin
     result:=0;
     tm    :=length(pc1);

     for i:=1 to length(pc) do
     begin
          if copy(pc,i,tm) = pc1 then
          begin
               result:=i;
               break;
          end;
     end;
end;

function cs(var h:string;xSep:string='|'):string;
var
   p:integer;
   w:string;
begin
     p:=posC(h,xSep);
     // 012|
     // 123|
     // abc|

     if p > 0 then
     begin
          result:=copy(h,1,p-1);
          w     :=h;
          h     :=trimRight(copy(w,p+1,50000));
     end
     else
     begin
          result:=trimRight(h);
          h     :='';
     end;
end;

function picInt(p:string):integer;
var
   ng:string;
begin
     p :=trim(p);
     ng:='';

     if copy(p,1,1) = '-' then
        ng:='-';

     p:=pegaSoNumeros(p);
     p:=zeDb(p);
     p:=ng+p;
     result:=strtoint(p);
end;

function pegaSoNumeros(AValue:string):string;
var
   i:integer;
begin
     result:='';

     for i:=plfStartStr to length(AValue)-plfEndStr do
     begin
          if (AValue[i] in ['0'..'9']) then
              result:=result + AValue[i];
     end;
end;

function zeDb(s:string):string;
begin
     s:=trim(s);
     s:=pegaSoNumeros(s);

     if testZ(s) then
        s:='0';

     while true do
     begin
         if (length(s) <= 1) or (s[plfStartStr] <> '0') then
             break;

         if s[plfStartStr] = '0' then
            s[plfStartStr]:=' ';

         s:=strTrans(s,' ','');
     end;

     result:=s;
end;

function testZ(cz:string):boolean;
begin
    testZ:=false;
    cz:=strTrans(cz,'%','');
    cz:=strTrans(cz,'/','');
    cz:=strTrans(cz,'-','');
    cz:=strTrans(cz,'\','');
    cz:=trim(cz);
    if(cz='')or(cz='0')or(cz='00')or(cz='0,00')or(cz='0.00')or(cz='0.0')or(cz='0,0')then
      testZ:=true;
end;

function strIgual(s1,s2:string):BOOLEAN;
begin
     s1:=ClearAcentos(s1,false);
     s2:=ClearAcentos(s2,false);
     s1:=trim(lowercase(s1));
     s2:=trim(lowercase(s2));
     result:=s1=s2;
end;

function clearAcentos(ca:string;_grafico:boolean):string;
var
   acentos:string;
   limpos :string;
   s:string;
   i,tm:integer;
begin
     if _grafico then
     begin
          result:=ca;
          exit;
     end;

     acentos:='���������������������������������������';
     limpos :='AAAAaaaaaEEEeeeIIIiiiOOOOooooUUUUuuuuCc';
     s      :=ca;
     tm     :=length(acentos);

     for i:=plfStartStr to tm-plfEndStr do
         s:=stringReplace(s,acentos[i],limpos[i],[rfReplaceAll]);

     for i:=128 to 255 do
         s:=stringReplace(s,chr(i),' ',[rfReplaceAll]);

     result:=s;
end;

function replicate(rpChar:string;rpTmh:integer):string;
var
   i:Integer;
begin
    result:='';
    for i:=1 to rpTmh do
        result:=result + rpChar;
end;

function cleanEnd(t,c:string):string;
var
  tm,
  i:integer;
begin
     t :=trim(t);
     tm:=length(t);
     for i:=tm downto 1 do
     begin
          if t[i - plfEndStr]=c then
             t[i - plfEndStr]:=#254
          else
              break
    end;
    result:=strTrans(t,#254,'');
end;


function testaPasta(p:string):boolean;
var
   d:array of string;
   w:string;
   q,s:string;
   i:integer;
   Attrib:integer;
begin
     result:=true;

(*
     p:=strTrans(p,'/','\');
     p:=cleanEnd(p,'\');

     for i:=1 to 3 do
         p:=strTrans(p,'\\','\');

     w:=p;

     i:=0;
     while true do
     begin
          s:=cs(w,'\');

          if s = '' then
             break;

          setlength(d,i+1);

          d[i]:=s;
          inc(i);
     end;

     s:='';
     for i:=0 to high(d) do
     begin
          s:=s+d[i]+'\';

          if posC(d[i],':') > 0 then
             continue;

          q:=cleanEnd(s,'\');

          TPath.

          //forcedirectories(q);
     end;

     result:=directoryexists(p);
     *)
end;

function sCh(s:string):PChar;
begin
     result:=pchar(s);
end;

function strZero(znivel: Integer; ztmh: integer): string;
var
   zValor:string;
begin
     zValor:=replicate('0',ztmh) + inttostr(znivel);
     result:=copy(zValor,(length(zValor) - ztmh) + 1, ztmh);
end;

function sDb(s:string;l:boolean=False):string;
begin
     if l then
        s:=limpar_char_proibido(s,[]);

     result:=(#34+s+#34);
end;

function limpar_char_proibido(s:string;outros:array of string):string;
var
   i:integer;
   c:string;
begin
     s:=strTrans(s,#34,'');
     s:=strTrans(s,#39,'');
     s:=strTrans(s,'|','');
     c:='';

     if high(outros)>-1 then
        if outros[0]=#0 then
           c:=' ';

     for i:=0 to high(outros) do
         s:=strTrans(s,outros[i],c);

     result:=s;
end;

function datDb(s:string):string;
begin
     s:=trim(s);

     if length(s) = 8 then
        s:=ddmmaa_ddmmaaaa(s);

     if dataNil(s) then
        result:='NULL'
     else
        result:=#34+DDMMAAAA_to_AAAAMMDD(s)+#34;
end;

function dataNil(dn:String):Boolean;
begin
     if dn = '30/12/1899' then
        dn:='';

     dn:=pegasonumeros(dn);
     result:=(dn='') or (dn=replicate('0',8)) or (length(dn)<>8);
end;

function DDMMAAAA_to_AAAAMMDD( data:string ):string;
var
   dia,mes,ano:string;
begin
     dia   :=copy(data,1,2); // --/01/2001
     mes   :=copy(data,4,2); // 27/--/2001
     ano   :=copy(data,7,4); // 27/01/----
     result:=ano+'-'+mes+'-'+dia;
end;

function user_debug(m:string):boolean;
begin
     result:=paramStr(1)='-debug';
     if m <> '' then
        if result then
           ui_msg('MODO DEBUG');
end;

function eliminarDecimal(ed:real;fd:integer):string;
var
  tm,ii,po:integer;

  flag,
  i,
  tmh,
  ponto:integer;

  valor,
  centenas,
  centavos:string;
begin
     flag:=0;

     if (fd > 0) or (fd = -1) or (fd = -2) or (fd = -3) or (fd = -5) or (fd = -6) then
     begin
          if fd = -1 then
          begin
               flag:=1;
               fd  :=3;
          end;

          if fd = -2  then
          begin
               flag:=2;
               fd  :=4;
          end;

          if fd = -4 then
          begin
               flag:=1;
               fd  :=4;
          end;

          if fd = -5 then
          begin
               flag:=2;
               fd  :=5;
          end;

          if fd = -6 then
          begin
               flag:=1;
               fd  :=5;
          end;

          if fd = -3 then
          begin
               flag:=2;
               fd  :=13;
          end;

          valor:=floattostrf(ed,ffFixed,15,fd);

          if flag = 2 then
          begin
               flag:=0;
               fd  :=2;
          end;
     end
     else
         valor:=floattostr(ed);

     ponto :=posC(valor,',');
     result:=valor;

     if ponto > 0 then
     begin
          tmh:=length(valor);

          for i:=tmh downto 1 do
          begin
               if valor[i - plfEndStr] <> '0' then
               begin
                    result:=copy(valor,1,i);
                    break;
               end;
          end;
     end;

     if fd > 0 then
     begin
          if posc(result,',') = 0 then
             result:=result+','+replicate('0',fd)
          else
          begin
               valor:=trim(copy(result,posC(result,',')+1,255));

               if length(valor) < fd then
               begin
                    result:=result + replicate('0',fd);
                    result:=copy(result,1,posC(result,',')+fd);
               end;
          end;
     end;

     if flag = 1 then
     begin
          valor:=result;
          ponto:=posc(valor,',');

          if ponto > 0 then
          begin
               tmh:=length(valor);

               for i:=tmh downto 1 do
               begin
                    if valor[i-plfEndStr] <> '0' then
                    begin
                         result:=copy(valor,1,i);
                         break;
                    end;
               end;
          end;
     end;

     result  :=cleanend(result,',');
     valor   :=result;
     centavos:='';
     po      :=posc(valor,',');

     if po > 0 then
     begin
          valor   :=trim(copy(result,1,po-1));
          centavos:=','+trim(copy(result,po+1,20));
     end;

     valor :=trim(picture([picf(valor)]));
     valor :=copy(valor,1,posC(valor,',')-1);
     valor :=valor + centavos;
     result:=valor;
end;

function picF(stp:string):real;
var
   PF :real;
   t,i:integer;
begin
     stp:=trim(stp);
     t  :=length(stp);

     if t = 0 then
     begin
          stp:='0';
          t  :=1;
     end;

     for i:=1 to t do
     begin
          if posC('0123456789,.-',copy(stp,i,1)) = 0 then
             stp[i]:=' ';
     end;

     stp:=strTrans(stp,' ','');

     //stp:=lowercase(stp);
     //stp:=strtrans(stp,' ' ,'');
     //stp:=strtrans(stp,'%' ,'');
     //stp:=strtrans(stp,'km','');
     //stp:=strtrans(stp,'$' ,'');

     if stp = '' then
        stp:='0';

     if testZ(stp) then
        stp:='0';

     stp:=strTrans(stp,'.','' );
     stp:=strTrans(stp,'r','.');

     //ThousandSeparator:='.';
     //DecimalSeparator :=',';
     //CurrencyDecimals :=2;

     pf:=strToFloat(stp);

     result:=pf;
end;

function picture(ppvalor:array of real): string;
var
   PValor:real;
   D,tamanho,ler: integer;
   SepDec,
   SepCen,
   decimal,
   centena,
   tmp,
   pp: string;
begin
     //ThousandSeparator:='.';
     //DecimalSeparator :=',';
     //CurrencyDecimals :=2;

     D     :=0;
     PValor:=ppvalor[0];

     if high(ppvalor) > 0 then
     begin
          pp:=floatToStr(ppvalor[1]);
          pp:=pegaSoNumeros(pp);

          if testz(pp) then
             pp:='0';

          D :=picInt(pp);
     end;

     if D = 0 then
        D:=2;

     //if D = 33 then
     //   D:=2
     //else
     //    if D = 2 then
            //ajusteArredondamento(pvalor);

     pp     :=format('%*.*f',[16,D,PValor]);
     tamanho:=length(pp);
     SepDec :='.';

     if SepDec <> '.' then
        SepCen:='.'
     else
        SepCen:=',';

     decimal:='0' + SepDec + replicate('0',D);

     for ler:=1 to tamanho do
     begin
          if (copy(pp,ler,1) = SepCen) or (copy(pp,ler,1) = SepDec) then
          begin
               decimal:=copy(pp,ler,(D + 1));
               break;
          end;
     end;

     centena:=copy(pp,1,tamanho-(D+1));
     tamanho:=length(centena);
     tmp    :='';

     while true do
     begin
          if (tamanho >= 3) and (trim(centena) <> '') then
          begin
               if tmp = '' then
                  tmp:=copy(centena,tamanho-2,3)
               else
                  tmp:=copy(centena,tamanho-2,3) + SepDec + tmp;

               centena:=copy(centena,1,tamanho-3);
               tamanho:=length(centena);
          end
          else
          begin
               tmp:=centena + tmp;
               break;
          end;
     end;

     tmp   :=strtrans(tmp,'-.','-');
     result:=replicate(' ',16) + tmp + decimal;
     result:=strRight(result,16);
end;

function strRight(srtext:string;srtmh:integer): string;
var
   srtm:integer;
begin
     srtm:=length(srText);

     if srtm <= srtmh then
     begin
          result:=srtext;
          exit;
     end;

     inc(srtm);

     result:=copy(srtext,srtm-srtmh,srtm);
end;

function pad(ptx:string;ptc:string;pth:integer):string;
var
   tmh:integer;
   ver:integer;
begin
     tmh:=length(ptx);
     if pth>tmh then
     begin
          for ver:=0 to (pth-tmh) do
              ptx:=ptx+ptc;
     end;
     result:=pchar(copy(ptx,1,pth));
end;

procedure ajusteArredondamento(var v:real);
var
   fiValor:REAL;

   g,s:string;
   p:integer;
   d:array[1..6] of integer;

begin
     s:=floatToStr(v);
     p:=posC(s,',');

     if p > 0 then
     begin
          fiValor:=strToFloat(copy(s,1,p-1));

          s:=trim(copy(s,p+1,6));

          for p:=1 to 6 do
              d[p]:=0;

          for p:=1 to length(s) do
              d[p]:=picInt(s[p]);

          if d[6] < 5 then
             d[6]:=0
          else
               begin
                    d[6]:=0;
                    if d[5]<9 then d[5]:=d[5]+1
                    else begin
                              d[5]:=0;
                              if d[4]<9 then d[4]:=d[4]+1
                              else begin
                                        d[4]:=0;
                                        if d[3]<9 then d[3]:=d[3]+1
                                        else begin
                                                  d[3]:=0;
                                                  if d[2]<9 then d[2]:=d[2]+1
                                                  else begin
                                                            d[2]:=0;
                                                            if d[1]<9 then d[1]:=d[1]+1
                                                            else begin
                                                                      d[1]:=0;
                                                                      fiValor:=fiValor+1
                                                                 end;
                                                       end;
                                             end;
                                   end;
                         end;
               end;

          if d[5]<5 then d[5]:=0
          else begin
                    d[5]:=0;
                    if d[4]<9 then d[4]:=d[4]+1
                    else begin
                              d[4]:=0;
                              if d[3]<9 then d[3]:=d[3]+1
                              else begin
                                        d[3]:=0;
                                        if d[2]<9 then d[2]:=d[2]+1
                                        else begin
                                                  d[2]:=0;
                                                  if d[1]<9 then d[1]:=d[1]+1
                                                  else begin
                                                            d[1]:=0;
                                                            fiValor:=fiValor+1
                                                       end;
                                             end;
                                   end;
                         end;
               end;

          if d[4]<5 then d[4]:=0
          else begin
                    d[4]:=0;
                    if d[3]<9 then d[3]:=d[3]+1
                    else begin
                              d[3]:=0;
                              if d[2]<9 then d[2]:=d[2]+1
                              else begin
                                        d[2]:=0;
                                        if d[1]<9 then d[1]:=d[1]+1
                                        else begin
                                                  d[1]:=0;
                                                  fiValor:=fiValor+1
                                             end;
                                   end;
                         end;
               end;

          if d[3]<5 then d[3]:=0
          else begin
                    d[3]:=0;
                    if d[2]<9 then d[2]:=d[2]+1
                    else begin
                              d[2]:=0;
                              if d[1]<9 then d[1]:=d[1]+1
                              else begin
                                        d[1]:=0;
                                        fiValor:=fiValor+1
                                   end;
                         end;
               end;
          (*
          if d[2]<5 then d[2]:=0
          else begin
                    d[2]:=0;
                    if d[1]<9 then d[1]:=d[1]+1;
                    else begin
                              d[1]:=0;
                              fiValor:=fiValor+1
                         end;
               end;

          if d[1]<5 then d[1]:=0
          else begin
                    d[1]:=0;
                    fiValor:=fiValor+1
               end;

           *)


          if d[3]>=5 then
          begin
               if d[2]=9 then
               begin
                    if d[1]=9 then
                    begin
                         fiValor:=fiValor+1;
                         d[1]:=0;
                         d[2]:=0;
                    end
                    else
                    begin
                         d[1]:=d[1]+1;
                         d[2]:=0;
                    end;
               end
               else d[2]:=d[2]+1;
          end;

          s:=floatToStr(fiValor) + ',' + inttostr(d[1]) + inttostr(d[2]);

          v:=picf(s);
     end;
end;

function formatarNome(n:string):string;
var
   P:tstringList;
   c,s:string;
begin
     n:=strTrans(n,'  ',' ');
     n:=strTrans(n,'  ',' ');
     n:=lowerCase(n);
     c:='';

     while n <> '' do
     begin
          s:=cs(n,' ');

          if (length(s) > 2) and (s <> 'ac') then
             s:=trim(upperCase(copy(s,1,1))+copy(s,2,length(s)));

          c:=c+' '+s;
     end;

     result:=trim(c);
end;

function ddmmaa_ddmmaaaa(data:string):string;
var
   a,
   dia,mes,ano:string;
begin
     ano:=copy(data,7,2); // 01/01/__
     mes:=copy(data,4,2); // 01/__/16
     dia:=copy(data,1,2); // --/01/16

     result:=dia+'/'+mes+'/20'+ano;
end;


function aaaammdd_to_ddmmaaaa(data:string):string;
var
   dia,mes,ano:string;
begin
     if length(data) = 8 then
        result:=ddmmaa_ddmmaaaa(data)
     else
     begin
           dia   :=copy(data,9,2); // 2001/01/--
           mes   :=copy(data,6,2); // 2001/--/02
           ano   :=copy(data,1,4); // ----/01/02
           result:=dia+'/'+mes+'/'+ano;
     end;
end;

function formataCnpj(pcgccpf:string): string;
var pcmax: integer;
    pcdig, pcstr0, pcstr1, pcstr2, pcstr3: string;
  { mascaras
    CGC 00.000.000/0000-00
    CPF     000.000.000-00 }

function MarcaNilcgc(mncgc:string;mntmh:integer):string;
var
  mnscan, mnpre: integer;
  mnbuffer: string;
begin
  mnbuffer:= mncgc;
  mncgc:= trim(mncgc);
  mnpre:= length( mncgc );
  mnpre:= mntmh-mnpre;

  if mnpre<=0 then
  begin
    result:= mnbuffer;
    exit;
  end;

  mnbuffer:='';

  for mnscan:=1 to mnpre do
      mnbuffer:=mnbuffer+'=';

  result:=mnbuffer+mncgc;
end;


begin

    pcgccpf:=trim(pegaSoNumeros( pcgccpf ));

    pcmax  :=0;

    if pcgccpf<>'' then
       pcmax:=length(pcgccpf);

    if (pcmax>14) or (pcgccpf='') then
    begin
        result:=pcgccpf;
        exit;
    end;

    pcmax :=15;
    pcdig :='';
    pcstr0:='';
    pcstr1:='';
    pcstr2:='';
    pcstr3:='';

    if analizecgc(pcgccpf) then
    begin
        pcgccpf:= MarcaNilcgc(pcgccpf,14);
        pcdig  := strtrans(copy(pcgccpf,pcmax- 2,2),'=','');
        pcstr0 := strtrans(copy(pcgccpf,pcmax- 6,4),'=','');
        pcstr1 := strtrans(copy(pcgccpf,pcmax- 9,3),'=','');
        pcstr2 := strtrans(copy(pcgccpf,pcmax-12,3),'=','');
        pcstr3 := strtrans(copy(pcgccpf,pcmax-14,2),'=','');
        result := pcstr3+'.'+pcstr2+'.'+pcstr1+'/'+pcstr0+'-'+pcdig;
    end
    else
    begin
        pcgccpf:= MarcaNilcgc(pcgccpf,14);
        pcdig  := pcgccpf;
        if (pcmax-2)>1 then
        pcdig  := strtrans(copy(pcgccpf,pcmax- 2,2),'=','');
        if (pcdig <>'') then result:= pcdig;
        pcstr0 := strtrans(copy(pcgccpf,pcmax- 5,3),'=','');
        if (pcstr0<>'') then result:= pcstr0+'-'+result;
        pcstr1 := strtrans(copy(pcgccpf,pcmax- 8,3),'=','');
        if (pcstr1<>'') then result:= pcstr1+'.'+result;
        pcstr2 := strtrans(copy(pcgccpf,pcmax-11,3),'=','');
        if (pcstr2<>'') then result:= pcstr2+'.'+result;
        pcstr3 := strtrans(copy(pcgccpf,pcmax-14,3),'=','');
        if (pcstr3<>'') then result:= pcstr3+'.'+result;
    end;
    result:= strtrans(result,'=','');
end;

function AnalizeCgc(cgccpf:string):boolean;
begin
     cgccpf:=strtrans(cgccpf,'.','');
     cgccpf:=strtrans(cgccpf,'-','');
     cgccpf:=strtrans(cgccpf,'/','');
     cgccpf:=strtrans(cgccpf,' ','');
     analizecgc:=(length(cgccpf)=14);
end;

procedure kNovoValor(sender:tobject;modo:word=2);
var
   c:tedit;
begin
     c:=(sender as tedit);

     if (not c.enabled) or (not c.visible) or (modo=0) then
         exit;

     c.text:='';
     c.setfocus;
end;

procedure kNumeros(var Key:Char;modo:WORD=2);
begin
     if modo>0  then
        if(((ord(key)>=48)and(ord(key)<=57)) or (key=#8) )then
        begin
        end
        else
        if ord(key) in [22,3] then
        else
        key:=#0;
end;

procedure kValor(sender:tobject;var Key:Char;modo:WORD=2;xExceto:string='');
var
   cVal:tedit;
begin
     if modo = 0 then
        exit;

     cVal:=(Sender as tedit);

     if ((ord(key) >= 48) and (ord(key) <= 57)) or
        ((key = #44) or (key = #46) or (key = #8)) or
        ((xExceto <> '') and (posc(xExceto,Key) > 0)) then
     begin
          if key = #46 then
             key:=',';

          if key = ',' then
          begin
               if posc(cVal.text,',') > 0 then
                  key:=#0;

               if cVal.SelLength = Length(cVal.text) then
               begin
                    key          :=',';
                    cVal.text    :='0';
                    cVal.SelStart:=3;
               end;
          end;
     end
     else
         key:=#0;
end;


function kEnter(sender:tobject;modo:WORD=2;save:WORD=0;cor:tcolor=$0a0b0c):BOOLEAN;
var
   cp:tedit;
begin
     cp:=(sender as tedit);
     with cp do
     begin
          //if cor <> $0a0b0c then
          //   color     :=cor
          //else
          //   color     :=clyellow;


          //font.color:=clblack;
          readonly  :=modo=0;
          if save=1 then
          hint      :=text;
     end;
     result:=modo=0;
end;

function kExit(sender:tobject;modo:WORD=2;data:word=0;hoje:word=0;cor:tcolor=$0a0b0c):BOOLEAN;
var
   cp:tedit;
begin
     cp:=(sender as tedit);

     with cp do
     begin
          //if (trim(editmask)='!99/99/9999;1;') and (modo in [1,2]) then
          //begin
          //    data_auto_digitar(cp,data);
          //
          //    if hoje=1 then
          //       if datanil(cp.text) then
          //          cp.text:=datetostr(date());
          //end;

          //if cor<>$0a0b0c then
          //   color:=cor
          //else
          //   color:=clwhite;

          //font.color:=clblack;
          readonly  :=true;
     end;
     result:=modo=0;
end;

procedure kKeyDown(F:tform; var Key:Word;CP:TObject=nil;MD:word=0);
var
   m:tedit;
begin
     if F = nil then
        exit;

        (*
     case key of

          vk_delete:begin
                         if CP is tedit then
                         begin
                              m:=(CP as tedit);
                              if m.Enabled and m.Visible then
                                 kNovoValor(CP,MD);
                         end;
                    end;
          vk_down,
          vk_return:myskip(F,0,0);
          vk_up    :myskip(F,1,0);
     end;
     *)
end;

function kData(sender:tobject;modo,cNow:WORD;xExit:boolean=False):boolean;
var
   cData:tedit;
begin
     result:=false;

     if xExit then
        kExit(Sender,modo);

     if modo=0 then
        exit;

     cData:=(sender as tedit);

     if cNow=1 then
        if datanil(cData.text) then
           cData.text:=datetostr(date());

     result:=formatarData(cData);
end;

procedure kHoras(sender:tobject;var key:char;modo:WORD);
var
   b,
   s:string;
   i:integer;
   cHora:tedit;
begin
     if modo=0 then
        exit;

     cHora:=(sender as tedit);
     if(((ord(key)>=48)and(ord(key)<=57))or(key=#8) )then
     begin
          if(key<>#8)then
          begin
               s:=trim(cHora.text+key);
               if length(s)=2 then
               begin
                    if testZ(s) then
                       s:='0';

                    i:=picint(s);

                    if i>23 then
                       i:=23;

                    s             :=strZero(i,2)+':';
                    cHora.text    :=s;
                    cHora.SelStart:=4;
                    key           :=#0;
               end;

               if length(s)=3 then
               begin
                    s             :=copy(s,1,2)+':';
                    cHora.text    :=s;
                    cHora.SelStart:=4;
               end;

               if length(s)=4 then
               begin
                    b:=s[4];

                    if testZ(b) then
                       b:='0';

                    i:=strtoint(b);

                    if i>5 then
                       i:=5;

                    b             :=inttostr(i);
                    s[4]          :=b[1];
                    cHora.text    :=s;
                    cHora.SelStart:=4;
                    key           :=#0;
               end;
          end;
     end
     else
     begin
          if(char(key)=':')or(char(key)='.')or(char(key)=',')or(char(key)=';') then
          begin
               s:=cHora.text;
               if length(s)<3 then
               begin
                    if testZ(s) then
                       s:='0';

                    i             :=strtoint(s);
                    s             :=strZero(i,2)+':';
                    cHora.text    :=s;
                    cHora.SelStart:=4;
               end;
          end;

          key:=#0;
     end;
end;

procedure myskip(tela:tform;lado:integer;pulo:integer);
begin
     try
        //tela.Perform(WM_NEXTDLGCTL,lado,pulo);
     except
     end;
end;

function formatarData(sender:tobject):BOOLEAN;
begin
     result:=formatData(sender,(sender as tedit).text);
end;

function formatData(sender:tobject;ctext:string): Boolean;
var
   dia,mes,ano: integer;
   str_d, str_m, str_a: string;
   cpmask: boolean;
begin
     result:=true;
     cpmask:=(sender.classtype=tedit);

     dia:=0; mes:=0; ano:=0;

     ctext:=pad(ctext,' ',10);

     str_d := trim(copy(ctext,1,2));
     str_m := trim(copy(ctext,4,2));
     str_a := trim(copy(ctext,7,4));

     if str_d<>'' then
     begin
          dia:=strtoint(trim(copy(ctext,1,2)));
          if str_m<>'' then
             mes:=strtoint(trim(copy(ctext,4,2)))
          else
             mes:=partedadata(Date,'M');
          if str_a<>'' then
             ano:=strtoint(trim(copy(ctext,7,4)))
          else
             ano:=partedadata(Date,'A');
     end;

     if(dia>0)and(mes>0) then
     begin
          if ano<21   then inc(ano,2000);
          if ano<100  then inc(ano,1900);
          if ano<1000 then inc(ano,2000);
     end;

     if dia>31 then dia:=31;

     if(dia=31)and(mes in [4,6,9,11])then dia:=30;

     if(mes=2)then
     begin
          if(dia>28)then
            if(Ano mod 4=0)and not((ano mod 100=0)and not(ano mod 400=0))then
               dia:=29
            else
               dia:=28;
     end;

{     CASE mes of
          4,6,9,11:dia:=30;
          1,3,5,7,8,10,12:dia:=31;
     ELSE
          if(Ano mod 4=0)and not((ano mod 100=0)and not(ano mod 400=0))then
             dia:=29
          else
             dia:=28;
     END;}

     if(((dia>0)and(dia<32))and((mes>0)and(mes<13))and((ano>1899)))then
     begin
          if cpmask then
          begin
               (sender as tedit).text:=strright('00'+inttostr(dia),2)+'/'+
                                     strright('00'+inttostr(mes),2)+'/'+
                                     strright('0000'+inttostr(ano),4);
          end;
     end
     else
     begin
          if((dia=0)and(mes=0)and(ano=0)) then
          begin
              if cpmask then
                (sender as tedit).text:=''
              else
          end
          else
          begin
               result:=false;
               (sender as tedit).text:='';
               ui_msg('Data inv�lida');
          end;
     end;
end;


function formatarHoras(sender:tobject;modo:WORD):string;
var
   cHora:tedit;
begin
     if modo=0 then exit;
     cHora     :=(sender as tedit);
     cHora.text:=FormatHora(cHora.text);
     result:=cHora.text;
end;

function formathora(hora:string):string;
var
  horas,pp,tm:integer;
begin
    result:=hora;
    hora:=trim(hora);
    tm  :=length(hora);
    pp  :=posC(hora,':');
    if pp=0 then
    begin
        if tm=0 then hora:='00:00';
        if tm=1 then hora:='0'+hora+':00';
        if tm=2 then
        begin
            horas:=strtoint(hora);
            if horas>23 then horas:=23;
            hora:=inttostr(horas);
            hora:=hora+':00';
        end;
        if tm=3 then
           hora:=copy(hora,1,2)+':'+copy(hora,3,1)+'0';
        if tm=4 then
           hora:=copy(hora,1,2)+':'+copy(hora,3,2);
    end
    else
    begin
        if pp=1 then hora:='00'+hora;
        if pp=2 then hora:='0'+hora;
        if(pp=3)and(tm=3)then hora:=hora+'00';
        if(pp=3)and(tm=4)then hora:=hora+'0';
    end;
    result:=hora;
end;

function ParteDaData( ED: TDateTime; TED: Char ): Word;
var
   eddia,
   edmes,
   edano:word;
begin
     decodedate(ED,edano,edmes,eddia);
     result:=0;

     if uppercase(TED) = 'D' then
        result:=eddia;

     if uppercase(TED) = 'M' then
        result:=edmes;

     if uppercase(TED) = 'A' then
        result:=edano;
end;

function filtrarChar(ffchar:string):string;
begin
     if trim(ffchar) <> ''then
     begin
          ffchar:=strtrans(ffchar,'.','');
          ffchar:=strtrans(ffchar,'-','');
          ffchar:=strtrans(ffchar,'/','');
          ffchar:=strtrans(ffchar,' ','');
          ffchar:=strtrans(ffchar,',','');
          ffchar:=strtrans(ffchar,':','');
          ffchar:=strtrans(ffchar,'\','');
     end;

     filtrarchar:=ffchar;
end;

function IfThen(sCondicao:boolean;A,B:string):string;
begin
     if sCondicao then
        result:=A
     else
        result:=B;
end;

function check_q_decimal(cd:real):integer;
var
  s:string;
  q,r,p:integer;
begin
    result:=0;
    s     :=floattostrf(cd,ffFixed,15,4);
    s     :=trim(s);
    p     :=posc(s,',');

    if p>0 then
    begin
         r:=length(s);

         for q:=p+1 to r do
         begin
              if s[q]<>'0' then
              begin
                   result:=1;
                   break;
              end;
         end;
    end;
end;

function PicDb(s:string):string;
begin
     s:=trim(s);
     s:=strTrans(s,' ','');
     s:=strTrans(s,'(','');
     s:=strTrans(s,')','');

     if s = '' then
        s:='0';

     result:=#34+strTrans(strTrans(strTrans(s,'%',''),'.',''),',','.')+#34;
end;

function fiDataTime(s:string;db:boolean):variant;
var
   fidata,
   fihora:string;
begin
     if db then
     begin
          fidata:=trim(copy(s, 1,10));
          fihora:=trim(copy(s,11,15));
          fidata:=aaaammdd_to_ddmmaaaa(fidata);
     end
     else
     begin
          fidata:=trim(copy(s, 1,10));
          fihora:=trim(copy(s,11,15));
          fidata:=ddmmaaaa_to_aaaammdd(fidata);
     end;
     if filtrarchar(fidata)='' then
        result:=datetimetostr(now)
     else
        result:=fidata+' '+trim(fihora);
end;

function fileTempor(t,e:string):string;
var
   i:integer;
   p,f:string;
begin
     if e = '' then
         e:='tmp';

     if t = '' then
        t:=pathz(''); //pathZ('\tmp\');

     t:=t+'\';
     t:=strtrans(t,'\\','\');

     while true do
     begin
          f:=strZero(random(random(20000)*random(20000)),8)+'.'+e;

          if not fileexists(t+f) then
             break;
     end;

     result:=t+f;
end;

function formatInt(i:string):string;
var
   t:integer;
   r,s:string;
begin
     i:=pegaSoNumeros(i);
     i:=replicate(' ',10)+i;
     t:=length(i);
     r:='';

     while true do
     begin
          s:=strright(i,3);

          if trim(s) = '' then
             break;

          if r = '' then
             r:=s + r
          else
             r:=s+'.'+r;

          dec(t,3);

          i:=copy(i,1,t);
     end;

     result:=trim(r);
end;

function arquivoIsImagem(f:string):boolean;
begin
     result:=False;
     f:=lowercase(f);

     if strright(f,4) = '.jpg' then
        result:=True;
end;

function iDb(s:string):string;
begin
     result:=(zedb(s));
end;

function fDb(v:currency):string;
begin
     result:=(picDB(floattostr(v)));
end;

function dDb(d:tdate):string;
begin
     result:=(DatDB(dateToStr(d)));
end;

function temString(tn:string):boolean;
var
  tni,
  tnsize: integer;
begin
     result:=False;
     tn    :=trim(tn);
     tnsize:=length(tn);

     for tni:=1 to tnsize do
     begin
          if(ord(tn[tni-plfEndStr]) < 48) or (ord(tn[tni - plfEndStr])>57)then
          begin
               result:=True;
               break;
          end;
     end;
end;

function StrToBytes(text: string; codePage: Word): TBytes;
begin
  case codePage of
    0: Result := TEncoding.Default.GetBytes(text);
    1200: Result := TEncoding.Unicode.GetBytes(text);
    1201: Result := TEncoding.BigEndianUnicode.GetBytes(text);
    20127: Result := TEncoding.ASCII.GetBytes(text);
    65000: Result := TEncoding.UTF7.GetBytes(text);
    65001: Result := TEncoding.UTF8.GetBytes(text);
  else
    begin
     // if codePage = GetACP() then begin
        Result := TEncoding.Default.GetBytes(text);
      //end else
      //begin
      //  with TEncoding.GetEncoding(codePage) do
      //  try
      //    Result := GetBytes(text);
      //  finally
      //    Free;
      //  end;
      //end;
    end;
  end;
end;

function difHoras(inicio,fim:tdatetime;resume:boolean=false;resume2:boolean=false):string;
var
   t:Real;
   seg,
   a,b:string;
   ho,
   mi,
   se,i:integer;

   jdia,
   jhora,
   jminuto,
   jsegundos:integer;

   vt:Real;
begin
     vt       :=DateUtils.SecondsBetween(fim,inicio);
     jdia     :=0;
     jhora    :=0;
     jminuto  :=0;
     jsegundos:=0;

     if inicio < fim then
     begin
          vt:=vt / 60;

          vt:=vt / 60;

          while vt > 24 do
          begin
               jdia:=jdia +  1;
               vt  :=vt   - 24;
          end;

          vt:=vt * 60;

          while vt > 60 do
          begin
               jhora:=jhora + 1;
               vt   :=vt   - 60;
          end;
     end;

     //jminuto:=trunc(vt);

     //ui_msg( floattostr(vt) );

     //if vt>59 then
     //begin
     //     jsegundos:=trunc(vt-60);
     //     jminuto  :=0;
     //end
     //else

     jminuto:=trunc(vt);

     jsegundos:=trunc(((vt-jminuto) * 100) / 100 * 60);

     result:=strZero(jhora,2)+':'+strZero(jminuto,2); //+':'+strZero(jsegundos,2);

     if resume then
     begin
          //ho:=picInt(copy(result,1,2));
          //mi:=picInt(copy(result,4,2));
          //se:=picInt(copy(result,7,2));

          result:='';
          seg   :='';

          if jsegundos = 60 then
          begin
               jsegundos:=0;
               jminuto  :=jminuto + 1;
          end;

          if jminuto = 60 then
          begin
               jminuto:=0;
               jhora  :=jhora + 1;
          end;

          if jhora = 60 then
          begin
               jhora:=0;
               jdia :=jdia + 1;
          end;

          if jsegundos > 0 then
             seg:=strZero(jsegundos,2)+'s';

          if jminuto > 0 then
             result:=strZero(jminuto,2)+'m';

          if jhora > 0 then
             result:=strZero(jhora,2)+'h'+result;

          if jdia <> 0 then
             result:=floattostr(jdia)+'d'+result;

          if resume2 then
          begin
               if result = '' then
                  result:=result + seg
          end
          else
              result:=result + seg;


          for i:=1 to length(result) do
              if result[i - plfEndStr] = '0' then
                 result[i - plfEndStr]:=' '
              else
                 break;

          result:=strTrans(result,' ','');
     end;
end;

procedure setMask(campo:tEdit;valor:Currency;ndfi:string='';espaco:real=0.5);
var
   e,w:integer;
   F:TForm;
   C:TControl;
begin
     campo.Text:=trim(picture([valor]));

     (*
     if ndfi = '' then
        campo.Text:=trim(picture([valor]))
     else
        if ndfi <> '!' then
        begin
          {$IFDEF PLUG_IN_SYS}
           campo.Text:=dfi(1,0,ndfi,'f');
          {$ENDIF}
        end;

     C:=campo.parent;
     F:=nil;

     while C <> nil do
     begin
          if (C is TForm) then
          begin
               F:=(C as TForm);
               break;
          end;

          C:=C.parent;
     end;

     if F = nil then
        exit;

     F.Canvas.Font.Assign(campo.Font);

     w:=F.Canvas.TextWidth(campo.Text);

     e:=trunc(F.Canvas.TextWidth(' ')*espaco);

     while w < (campo.Width-8) do
     begin
          campo.Text:=' '+campo.Text;
          w         :=F.Canvas.TextWidth(campo.Text)+e;
     end;
     *)
end;

procedure resolveRuaNumero(var s1,s2,s3:string);
var
   t,i:integer;
begin
     s2:='';
     s3:='';

     if s2 = '' then
     begin
          t:=length(s1);

          for i:=t downto 1 do
          begin
               if copy(s1,i,1) = ',' then
               begin
                    s2:=trim(copy(s1,i+1,255));
                    s1:=trim(copy(s1,1,i-1));
                    break;
               end;
          end;
     end;

     if s3 = '' then
     begin
          t:=length(s2);

          for i:=1 to t do
          begin
               if copy(s2,i,1) = ' ' then
               begin
                    s3:=trim(copy(s2,i+1,255));
                    s2:=trim(copy(s2,1,i-1));
                    break;
               end;
          end;
     end;

     s3:=trim(s3);

     if copy(s3,1,1) = '-' then
        s3:=trim(copy(s3,2,255));

     //ParseText(s1,false);
     //ParseText(s2,false);
     //ParseText(s3,false);
end;

function sqlDate(nCampo,oTipo,vData:string):string;
begin
     result:='(to_days('+nCampo+')'+oTipo+'to_days('#34+DDMMAAAA_to_AAAAMMDD(vData)+#34'))';
end;

procedure extrairIds(s:string;var c,d:string);
var
   i,p:integer;
begin
     c:='';
     d:=s;
     p:=0;

     for i:=length(s) downto 1 do
     begin
          if copy(s,i,1) = '(' then
          begin
               p:=i;
               break;
          end;
     end;

     if p > 0 then
     begin
          c:=trim(copy(s,p+1,255));
          c:=strTrans(c,')','');
          d:=trim(copy(s,1,p - 1));
     end;
end;

function CnpjCpfValido(n:string):BOOLEAN;
var
   v:integer;
begin
     v:=TestCPFCGC(n);
     result:=(v = 2) or (v = 3);
end;

function testCPFCGC(AValue:string): Integer;
var
   localDoc : string;
   soma,
   ii,jj,
   digito,
   qmode:Integer;
begin
    result  :=-1;
    AValue  :=pegaSoNumeros(Avalue);
    localDoc:=trim(AValue);
    qmode   :=length(AValue);

    if qmode in [11,14] then
    else
        result:=1;

    if(qmode = 0) or (result = 1)then
       exit;

    result:=0;

    for jj := 0 to 1 do
    begin
        Soma := 0;
        case qmode of
             14: for ii := 1 to (12 + jj) do
                     if ii < (5 + jj) then
                        Inc(soma, picInt(Copy(localDoc,ii,1))*( 6+jj-ii))
                     else
                        Inc(soma, picInt(Copy(localDoc,ii,1))*(14+jj-ii));
             11: for ii := 1 to (9 + jj) do
                     Inc(Soma, picInt(localDoc[10+jj-ii]) * (ii+1));
        end;

        digito := 11 - (soma mod 11);

        if digito > 9 then
           digito := 0;

        case qmode of
             14: if digito <> picInt(localDoc[(13+jj) - plfEndStr]) then
                    exit; {d�gito inv�lido}
             11: if digito <> picInt(localDoc[(10+jj) - plfEndStr]) then
                    exit; {d�gito inv�lido}
        end;
    end;

    case qmode of
         14:result:=2;
         11:result:=3;
    end;
end;

function diaDaSemana(d:string;feira:boolean=false):string;
var
  ADate:TDateTime;
  days :array[1..7] of string;
  i    :integer;
begin
     days[1]:='Domingo';
     days[2]:='Segunda';
     days[3]:='Terca';
     days[4]:='Quarta';
     days[5]:='Quinta';
     days[6]:='Sexta';
     days[7]:='Sabado';

     if datanil(d)then
        result:=''
     else
     begin
          ADate :=strtodate(d);
          i     :=DayOfWeek(ADate);
          result:=days[i];

          if i in [1,7] then
          begin
          end
          else
          begin
               if feira then
                  result:=result+'-feira';
          end
     end;
end;

function faixa_de_comandas(nComanda:Integer):Boolean;
begin
     result:=False;

     if COMANDAS_INICIO > 0 then
        result:=(nComanda >= COMANDAS_INICIO) and (nComanda <= COMANDAS_FINAL);
end;

function faixa_de_mesas(nMesa:Integer):Boolean;
begin
     result:=(nMesa >= MESAS_INICIO) and (nMesa <= MESAS_FINAL);
end;


end.
