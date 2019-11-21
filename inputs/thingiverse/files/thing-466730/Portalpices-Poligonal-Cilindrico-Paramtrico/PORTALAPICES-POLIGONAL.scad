//..Parametric Portalápices Poligonal. Test Customizer Thingiverse by www.Bioplastic3d.es


diametro=50;
altura=80;
lados=6;
grosor=3;


difference (){
cylinder(r=diametro/2,h=altura,center=true,$fn=lados);

translate([0,0,grosor])
	cylinder(r=diametro/2-grosor,h=altura,center=true,$fn=lados);
}


