%HDB3.m
%Autor: Carlos Alberto Ortega Huembes
%Viva Nicaragua!!!!
%a.	S?# de pulsos desde la última violación es un número impar pero negativo  el código de sustitución es 000-  (000V)
%b.	S?# de pulsos desde la última violación es un número impar pero positivo  el código de sustitución es 000+  (000V)
%c.	S?# de pulsos desde la última violación es un número par pero negativo  el código de sustitución es +00+  (B00V)
%d.	S?# de pulsos desde la última violación es un número par pero positivo  el código de sustitución es -00-  (B00V)

xn=[1 0 1 1 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 1 0]; %Codigo binario de Entrada
yn=xn;                                          %Codigo a Modificar
num=0;                                          %variable para contar los 1s y determinar si son pares o impares
%Generacion de Codigo AMI
for k=1:length(xn)
    if xn(k)==1
       num=num+1;                               
         if num/2== fix(num/2)                  %Condicion para numeros de 1s pares 
              yn(k)=-1;
         else
             yn(k)=1;                           %Condicion para numeros de 1s impares
         end
    end
end
                                                
%conteo de 0s continuos para cambiar el codigo por 000v o B00V
num=0;                                           %Reinicio de la variable de conteo de 1s
yh=yn;                                           %Variable nueva del codigo almacenado en yn
sign=0;                                          %Variable de signo
V=zeros(1,length(yn));                           %Variable para guardar las violaciones (V)
B=zeros(1,length(yn));                           %Varible para guardar las B
for k=1:length(yn)
    if yn(k)==0
       num=num+1;                               %Incremento del contador de 0s
         if num== 4                             %Comprueba si hay 4 ceros continuos para realizar el cambio
           num=0;                               %Reestablece el contador de 0s
           yh(k)=1*yh(k-4);                     
           V(k)=yh(k);                      %Guarda los bits de violacion (V)
           if yh(k)==sign                   %Comprueba si el bit yh(k) es igual al signo
              yh(k)=-1*yh(k);               %Invierte el signo para evitar signos iguales en los bits de violacion
              yh(k-3)=yh(k);                %Cambia el primer 0 para generar el codigo B00V
              B(k-3)=yh(k);                 %Guarda las B producidas en hdb3
              V(k)=yh(k);                   %Guarda el bit de violacion con el signo ya invertido
              yh(k+1:length(yn))=-1*yh(k+1:length(yn));%Alterna los signos de los 1s despues de detectar un cambio de signo.              
           end
           sign=yh(k);                         %Guarda el signo de la violacion
         end
       else
          num=0;                            %Reestablece el contador de 0s
      end
end                                         
re=[xn',yn',yh',V',B'];                     %Variable que guarda en forma de columna el codigo de entrada,
                                            %codigo AMI,codigo
                                            %hdb3,variable con el bit de
                                            %violacion, variable con el bit
                                            %de relleno.
                                            
%Parte para decodificar la señal. Primero se consigue que quede de nuevo la
%señal AMI
input=yh;                                   %Codigo en Hdb3
decode=input;                               %Variable con el codigo Hdb3 a reconstruir
sign=0;                                     %Variable para guardar el signo de los 1s 
for k=1:length(yh)
    if input(k)~=0
      if sign==yh(k)                        %si existen dos 1s con el mismo signo, estos son
         decode(k-3:k)=[0 0 0 0];           %cambiados por 0000
      end
      sign=input(k);                        %Va guardando el signo de los 1s
    end
end
decode=abs(decode);                         %Valor Absoluto para volver los 1 negativos a positivos

%Parte para graficar
figure(2)
subplot(3,1,1);stairs([0:length(xn)-1],xn);axis([0 length(xn) -2 2]);title('Codigo Binario Transmitido');grid on;%grafica la el codigo binario de Entrada
subplot(3,1,2);stairs([0:length(xn)-1],yh);axis([0 length(xn) -2 2]);title('Codigo HDB3');grid on;%grafica el codigo en hdb3
subplot(3,1,3);stairs([0:length(xn)-1],decode);axis([0 length(xn) -2 2]);title('Codigo Binario Recibido');grid on;%grafica la señal restaurada

figure(2)
subplot(4,1,1);stairs([0:length(xn)-1],xn);axis([0 length(xn) -2 2]);title('Codigo Binario Transmitido');grid on;%grafica la el codigo binario de Entrada
subplot(4,1,2);stairs([0:length(xn)-1],yn);axis([0 length(xn) -2 2]);title('Codigo AMI');grid on;%grafica la el codigo binario de Entrada
subplot(4,1,3);stairs([0:length(xn)-1],V);axis([0 length(xn) -2 2]);title('Codigo con bits de Violacion');grid on;%grafica la el codigo binario de Entrada
subplot(4,1,4);stairs([0:length(xn)-1],B);axis([0 length(xn) -2 2]);title('Codigo con bits de Relleno');grid on;%grafica la el codigo binario de Entrada