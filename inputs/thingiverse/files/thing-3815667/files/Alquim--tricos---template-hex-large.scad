
altura=2;
rFuro=2.5;
geometria=6;
rCentro=50;
deltaFuro=rFuro*12+altura;
angulo=360/geometria;
furos=2;
borde=rFuro*6;
offsetRfuro=5;
offsetExterior=-13;

resol=48; //quantidade de seegmentos dos cilindros dos furos
rHub=deltaFuro*(furos-1)+rCentro+borde;

difference() {
    color("red")
    ;
minkowski()
{color("red")
    cylinder(r=rHub+offsetExterior,h=altura,center=true,$fn=geometria);
  cylinder(r=rHub/4,h=1,$fn=50);
}
    union() {
        color("blue")
            for (a = [ 0 : angulo : 360 ])
            for (b = [ 0: 1 : furos-1 ])
               translate([cos(a)*(deltaFuro*b+rCentro), sin(a)*(deltaFuro*b+rCentro), 0]) cylinder(r=rFuro+offsetRfuro,h=altura*4,center=true,$fn=resol);
    }
}
