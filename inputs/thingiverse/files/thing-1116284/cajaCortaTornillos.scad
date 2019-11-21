//translate([-16.5+disth/2,24+pos,10])cylinder(r=3.3, h=20, $fn=6); 


largoTornilloInicial=20;
sobrante=2;
numTornillos = 5;

largo_caja=30;
alto_caja=15;
diametro_tornillo=3;
cabeza_tornillo=6.2;
grosorPared=3;

grosorSoporte=4.4;

largoTornillo=largoTornilloInicial-sobrante;


anchoCaja=cabeza_tornillo*((numTornillos*2)+2);



module caja(){
cube([anchoCaja, largoTornillo*2, alto_caja]);
}
module huecoCaja(){
	translate([-2, grosorPared, 4])
	cube([anchoCaja+4, (largoTornillo*2)- grosorPared*2, alto_caja]);
}

module soporte(){
	difference(){
		translate([0, largoTornillo-(grosorSoporte+sobrante), 4])
			cube([anchoCaja ,(sobrante*2) + (grosorSoporte*2),alto_caja-4]);
			tuercas();	
		translate([-1, largoTornillo-(sobrante), 4])
			cube([anchoCaja+2 ,(sobrante*2) ,alto_caja-7]);
		translate([-1, largoTornillo-0.5, 8])
			cube([anchoCaja+2 ,1 ,alto_caja-7]);
	}
translate([0, largoTornillo-(sobrante), 0])
			cube([anchoCaja,(sobrante*2) ,alto_caja-8.5]);
}


module tuercas(){

for( i = [1:2:numTornillos*2] ){
	translate([i* cabeza_tornillo, largoTornillo+1+(grosorSoporte+sobrante), 8.3])
	rotate([90,0,0]) cylinder(r=3.3, h=3.4, $fn=6);
}

for( i = [1:numTornillos] ){
	translate([(i*2)*cabeza_tornillo, grosorPared - 1 + largoTornillo-(grosorSoporte+sobrante), 8.3])
	rotate([90,0,0]) cylinder(r=3.3, h=3.4, $fn=6);
}

}



module tornillo(){
translate([0, 0, 0])
for( i = [1:numTornillos] ){
	translate([(i*2)*cabeza_tornillo, largoTornilloInicial, 8.3])
	rotate([90,0,0]) cylinder(r=1.5, h=largoTornilloInicial+3, $fn=16);
}
translate([0, 0, 0])
for( i = [1:2:numTornillos*2] ){
	translate([i* cabeza_tornillo, (largoTornilloInicial*2)-1, 8.3])
	rotate([90,0,0]) cylinder(r=1.5, h=largoTornilloInicial+3, $fn=16);
}
}


module final(){
	difference() {
		caja();
		huecoCaja();
		tornillo();
tornillo();
	}

soporte();


}
final();

