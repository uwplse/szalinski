$fn = 80;
pernas = 4; //quantidade de pernas do spinner
raio = 25;  //distancia do centro (ponto 0,0,0) até o centro do cilindro externos
espessura = 12.5; //espessura entre cilindros internos e externos
raiorolamento = 11.3; // 1/2 do diametro do rolamento 
altura = 8; //altura do objeto no eixo Z
deslocamento = 0;

//subtração dos sólidos
difference() {
    //união dos sólidos que vão ser cortados
    union() {
        //função de repetição (loop) e condição da repetição(i = [1:variavel]) repetir 1, 2, 3, 4 (...) até variavel
        for(i = [1:pernas]) {
            //função de contorno
            hull(){
                //função de rotação em graus ([x,y,z])
                rotate([0,0,(360/pernas)*i]) {
                    //função de translado ([x,y,z])
                    translate([raio,0,0]){
                        //construção dos cilindros das pontas externos
                        cylinder(altura, r = raiorolamento + espessura, true);
                    //fim da função de translado
                    }
                //fim da função de rotação
                }
                //construção do cilindro central externo
                cylinder(altura, r = raiorolamento + espessura, true);
            //fim da função de contorno
            }
        //fim da função de repetição
        }
    //fim da função união
    }
    //união dos sólidos que vão realizar o corte
    union() {
        //função de repetição (loop) e condição da repetição (i = [1:variavel]) repetir 1, 2, 3, 4 (...) até variavel
        for(i = [1:pernas]) {
            //função de rotação em graus ([x,y,z])
            rotate([0,0,((360/pernas)*i)+deslocamento]) {
                //função de translado ([x,y,z])
                translate([raio,0,0]){
                    //construção dos cilindros das pontas internos 
                    cylinder(altura + 1, r = raiorolamento, true);
                //fim da função de translado
                }
            //fim da função de rotação
            }
        //fim da função de repetição
        }
        //contrução do cilindro central interno
        cylinder(altura + 1, r = raiorolamento, true);
    //fim da função união
    }
//fim da função de subtração
}