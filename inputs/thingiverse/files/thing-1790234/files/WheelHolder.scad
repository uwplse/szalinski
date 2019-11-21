TamanhoInternoX = 40;
TamanhoInternoY = 19;
Altura = 20;
Espessura = 2;

Distancia = 17.5;
DiametroRolamento = 10;
$fn=50;

difference(){
    minkowski(){
        cube([TamanhoInternoX+Espessura*2,
            TamanhoInternoY+Espessura*2,Altura]);
        sphere(0.5);
    }
    translate([Espessura,Espessura,-2])
        cube([TamanhoInternoX,TamanhoInternoY,Altura+4]);
    
    translate([TamanhoInternoX/2-Distancia/2+Espessura,
               -TamanhoInternoY/2,
               Altura/2]){
        rotate(a=[-90,0]){
            translate([Distancia,0]){
                hull(){
                    cylinder(d=DiametroRolamento,
                             h=TamanhoInternoY*2);
                    translate([0,-Altura])
                        cylinder(d=DiametroRolamento,
                                 h=TamanhoInternoY*2);
                }
            }
            hull(){
                cylinder(d=DiametroRolamento,
                           h=TamanhoInternoY*2);
                translate([0,-Altura])
                    cylinder(d=DiametroRolamento,
                             h=TamanhoInternoY*2);
            }
        }
    }
}