SET SERVEROUTPUT ON
DECLARE
  AN_DATE     VARCHAR2(100) := '19-FEB-2018 23:59:59';
  NEW_DATE    VARCHAR2(100);
BEGIN
  
  //este select � o importante! ele a partir de uma data setada ele subtrai x horas desta data, caindo ou nao at� em uma data posterior
  //alterar o INTERVAL '50'
  SELECT TO_CHAR(TO_DATE(AN_DATE,'DD-MON-YY HH24:MI:SS')- INTERVAL '50' HOUR , 'DD-MON-YY HH24:MI:SS') 
  INTO NEW_DATE
  FROM DUAL;   
  
  IF (TO_DATE(NEW_DATE,'DD-MON-YY HH24:MI:SS') >= TO_DATE('15-OCT-17','DD-MON-YY HH24:MI:SS' )) OR (TO_DATE(NEW_DATE,'DD-MON-YY HH24:MI:SS') < TO_DATE('18-FEB-18', 'DD-MON-YY HH24:MI:SS')) THEN
    DBMS_OUTPUT.PUT_LINE('DENTRO DO HOR�RIO DE VER�O');
    NEW_DATE := TO_CHAR(TO_DATE(NEW_DATE,'DD-MON-YY HH24:MI:SS')+ INTERVAL '1' HOUR , 'DD-MON-YY HH24:MI:SS');
  END IF;
  DBMS_OUTPUT.PUT_LINE('HOR�RIO FINAL: ' || NEW_DATE );
END;








SELECT * FROM ALL_TABLES
WHERE OWNER NOT IN ('SYS', 'SYSTEM', 'XDB', 'EXFSYS')
ORDER BY TABLE_NAME;


--SELECT TO_CHAR(TO_DATE('11/06/2015 00:00','dd/mm/yyyy HH24:MI') - (2 / 24), 'MM-DD-YYYY HH24:MI') FROM DUAL


/*
Fim hor�rio ver�o 17 de fevereiro de 2018 AS 23:59
Data Expedi��o 19/02/2018 (23:59:59)

Usu�rio configura no sistema o fechamento do site -15h:
A data esperada para fechamento do site ser� 19/02/2018 (08:59:59) Fora do hor�rio de ver�o
*/
SELECT TO_CHAR(TO_DATE('19-FEB-2018 23:59:59','DD-MON-YY HH24:MI:SS')- INTERVAL '15' HOUR, 'DD-MON-YY HH24:MI:SS') 
from dual;




/*
CHANG
Os cen�rios abaixo est�o incorretos:
Usu�rio configura no sistema o fechamento do site -50h: A data esperada para fechamento do site ser� 17/02/2018 (21:59:59) Dentro do hor�rio de ver�o
- Horario inicial - 19/02/2018 (23:59:59) � fora do horario de ver�o
- Hora final : 19/02/2018 (23:59:59) � 50 h = 17/02/2018 (21:59:59), horario de ver�o valido assim o sistema executa uma subtra��o de 1 hora: 17/02/2018 (21:59:59) � 1 = 17/02/2018 (20:59:59).


CAMPELO
�Hora final : 19/02/2018 (23:59:59) � 50 h = 17/02/2018 (21:59:59)�
O resultado desta opera��o, se o calend�rio utilizado possuir configurado o hor�rio de ver�o ser� 17/02/2018 (22:59:59).
Como voc� realiza o ajuste de 1 hora no caso de entrada em hor�rio de ver�o o hor�rio final ser� 17/02/2018 (21:59:59), conforme esperado.
*/

--HORARIO DE VER�O SOMA 1 HORA
SELECT TO_CHAR(TO_DATE('19-FEB-2018 23:59:59','DD-MON-YY HH24:MI:SS')- INTERVAL '50' HOUR, 'DD-MON-YY HH24:MI:SS') 
FROM DUAL;

--PROGRAMA JAVA EST� SUBTRAINDO 1 HORA P/ A HORA BATER COM A HORA DO BANCO


