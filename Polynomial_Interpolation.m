%Variables temporales
j = 1;
pl = 1;

%Generamos la señal de donde tomaremos
%las muestras para la interpolación
for i = 1 : 200
    x(1,i) = i;
    senal(1,i) = 2*(log(2*i))*sin(i);
end


%Acumulamos un rango de la señal que será
%mandado a la función de la interpolación
for i = 1 : 200
    %Al obtener suficientes valores mandamos llamar
    %la función de interpolación
    if(j == 11)
        %La función es llamada, de los 10 valores que tomamos
        %solo utiliza 4 dentro de la misma función
    ys = interpolacion(x(1,i-10:3:i),senal(1,i-10:3:i),pl);
    j = 1;
    pl = pl + 1;
    end
j = j + 1;
end

%Función interpolación
function[pol] = interpolacion(x, fx, pl)
    %Declaración de matrices para datos
    [f,c] = size(x);
    fe = fx;
    l = ones(f,c-1);
    pol = zeros(f,20);
    lf = l;
    lf(1) = fx (1);
    %Declaración de las variables temporales del código
    ticket = c - 2;

    i = 1;
    v = 1;
    j = 1;
    r=1;
    mult = 1;
    p=0;

    while(ticket ~= 0)
        if(i == (c+1)-j)
            %El primer valor de la matriz entrara a la matriz interpolada
            lf(j+1) = l(1);
            %Actualización de valores temporales
            i = 1;
            v = v + 1;
            fx = l;
            j = j + 1;
            %La matriz se reinicia
            l = ones(f,c-j);
            ticket = ticket - 1;
        end
    
    %Ecuación de la interpolación, donde las variables
    %estaran cambiando en cada ciclo
    l(i) = (fx(i+1) - fx(i))/(x(i+v) - x(i));
    i = i + 1;
    end
    
    
%Se añade ultimo valor a matriz final
lf(j+1) = l(1);
%Tomamos 101 valores del rango de la matriz x
X = linspace(x(1), x(c), 20);
%Ciclo donde se generaran los valores de la matriz interpolada
while (f <= length(X))
    for i = 1 : c
    %Ciclo para obtener los valores a multiplicar
        for j = 1 : r - 1
        mult = mult * (X(f)-x(j));
        end
    %Se suma el valor de p con la posición de la matriz final y
    %se multiplica
    
        r = r + 1;
        p = p + lf(i) * mult;
    mult = 1;
    end
%Se añade ese valor a la matriz interpolada
pol(f) = p;
%Se actualizan valores temporales
p=0;
r=1;
f = f + 1;
end

%Graficamos la tabla x y la tabla interpolada
subplot(2,1,pl)
plot(x,fe,'g--o',X,pol,'b--x')
end