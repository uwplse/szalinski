///////////////////////////////////////////////////////////////////////////////////////////////
// arm customizer[OBLOBOTS] 
//////////////////////////////////////////////////////////////////////////////////////////////////
// (c) Jorge Medal (@oblomobka) - Sara Alvarellos (@trecedejunio) 2014-05 
//////////////////////////////////////////////////////////////////////////////////////////////////
// GPL license
//////////////////////////////////////////////////////////////////////////////////////////////////

/* [Parámetros del brazo] */

// Como quieres que esté construido el brazo del oblobot
TIPO_BRAZO="Rectas";		//[Rectas,Curvas]

Longitud_Brazo=70;		//[45:100]

Hombro=18;				//[18:Pequeño,22:Mediano,28:Grande]

Mano=25;					//[18:Pequeña,25:Mediana,32:Grande]

Tipo_Mano=4;				//[1,2,3,4]

/* [Parámetros de la unión] */

TIPO_UNION="Macho";		//[Hembra,Macho]

Diametro=8;				//[3:15]
Altura=15;				//[5:20]

/* [Hidden] */

Altura_brazo=7;
Altura_brazo_b=2;


if(TIPO_BRAZO=="Rectas"){
	if(TIPO_UNION=="Hembra"){
		arm_union_quadrangle(arm=[Hombro,Altura_brazo,Altura_brazo_b,Longitud_Brazo],hand=[Mano,Altura_brazo-2,2+Tipo_Mano*2],pin=[Diametro,20]);
		}
	else{
		union(){
			arm_quadrangle(arm=[Hombro,Altura_brazo,Longitud_Brazo],hand=[Mano,Altura_brazo-2,2+Tipo_Mano*2]);
			translate([0,0,Altura_brazo])
				pin_simple(pin=[Diametro,Altura],base=[Hombro,Diametro+2,Altura_brazo_b,4]);
			}
		}
	}

else{
	if(TIPO_UNION=="Hembra"){
		arm_union_cylindrical(arm=[Hombro,Altura_brazo,Altura_brazo_b,Longitud_Brazo],hand=[Mano,Altura_brazo-2,1+60*(Tipo_Mano-1)],pin=[Diametro,20]);
		}
	else{
		union(){
			arm_cylindrical(arm=[Hombro,Altura_brazo,Longitud_Brazo],hand=[Mano,Altura_brazo-2,1+60*(Tipo_Mano-1)]);
			translate([0,0,Altura_brazo])
				pin_simple(pin=[Diametro,Altura],base=[Hombro,Diametro+2,Altura_brazo_b,50]);
			}
		}
	}

	


// Limites


// ARMS | HANDS

	d_pin_minmax=[10,30];			//	d_pin=lim(d_pin_minmax[0],pin[0],d_pin_minmax[1]);			
	h_pin_minmax=[0,10];			//	h_pin=lim(h_pin_minmax[0],pin[1],h_pin_minmax[1]);

	// C
	d_arm_minmax=[10,40];			// 	d_arm=lim(d_arm_minmax[0],arm[0],d_arm_minmax[1]);
								//	d_arm=lim(d_pin+1,arm[0],d_arm_minmax[1]);	
	h_arm_minmax=[5,25];			// 	h_arm=lim(h_arm_minmax[0],arm[1],h_arm_minmax[1]);
	armpit_minmax=[0.3,60];		//	armpit=lim(armpit_minmax[0],arm[2],armpit_minmax[1]);
	l_arm_minmax=[20,120];		// 	l_arm=lim(d_arm+d_hand,arm[2],l_arm_minmax[1]);	

	d_hand_minmax=[10,60];		//	d_hand=lim(d_hand_minmax[0],hand[0],d_hand_minmax[1]);
	h_hand_minmax=[3,25];			//	h_hand=lim(h_hand_minmax[0],hand[1],h_arm-0.5);
	angle_hand_minmax=[0,180];	//	angle_hand=lim(angle_hand_minmax[0],hand[2]/2,angle_hand_minmax[1]);

	// Q
	x_arm_minmax=[5,25];			// 	x_arm=lim(x_arm_minmax[0],arm[1],x_arm_minmax[1]);
	y_arm_minmax=[10,40];			// 	y_arm=lim(y_arm_minmax[0],arm[0],y_arm_minmax[1]);
	z_arm_minmax=[20,120];		//	z_arm=lim(y_arm+5+d_hand,arm[2],z_arm_minmax[1]);

	n_hand_minmax=[4,12];			// 	n_hand=lim(n_hand_minmax[0],2*floor(hand[2]/2),n_hand_minmax[1]);
								//	h_hand=lim(h_hand_minmax[0],hand[1],x_arm-0.5);

// limita los posibles valores de x, que siempre estarán comprendidos entre un minimo(a) y un maximo(z)
function lim(a,x,z)=max(a,min(x,z));

//////////////////////////////////////////////////////////////////
///////////// MODULO arm_union_cylindrical()  ////////////////////

module arm_union_cylindrical (	arm=[18,10,1,65],					// [d,h,armpit,l]
								hand=[22,8,120],					// [d,h,ang]
								pin=[6,20],						//  
								play=0,
								resolution=50
								){

d_pin=lim(d_pin_minmax[0],pin[0],d_pin_minmax[1]);			// diámetro del pin
h_pin=lim(h_pin_minmax[0],pin[1],h_pin_minmax[1]);			// longitud del pin

d_arm=lim(d_pin+1,arm[0],d_arm_minmax[1]);					// medida del brazo: fondo	
h_arm=lim(h_arm_minmax[0],arm[1],h_arm_minmax[1]);			// medida del brazo: ancho
armpit=lim(armpit_minmax[0],arm[2],armpit_minmax[1]);		// medida de la axila

d_hand=lim(d_hand_minmax[0],hand[0],d_hand_minmax[1]);

l_arm=lim(d_arm+d_hand,arm[3],l_arm_minmax[1]);				// medida del brazo: longitud

difference(){
	union(){
		arm_cylindrical(arm=[d_arm,h_arm,l_arm],hand=hand);
		translate([0,0,h_arm])cylinder(r1=d_arm/2,r2=(d_pin+4)/2,h=armpit);
		}
	// Huecos hexagonales para introducir una espiga
	gap(gap=pin,deep=pin[1],play=play);
	translate([0,0,h_arm+armpit])rotate([180,0,0])
		gap(gap=pin,deep=pin[1],play=play);
	}
}

// -------------- Fin del módulo arm_union_cylindrical () -----------------
// ------------------------------------------------------------------------


//////////////////////////////////////////////////////////////////
///////////// MODULO arm_union_quadrangle()  ////////////////////

module arm_union_quadrangle (	arm=[18,10,2,65],			// [grosor(x),fondo(y),armpit,longitud(z)] Medidas de los Brazo
							hand=[22,8,8],			// [d,h,n lados]
							pin=[6,20],				
							play=0,
							resolution=50
							){

// valores con límites: acotados entre un máximo y un mínimo (los valores límite están en <limits_oblobots.scad>)
d_pin=lim(d_pin_minmax[0],pin[0],d_pin_minmax[1]);		// diámetro del pin
h_pin=lim(h_pin_minmax[0],pin[1],h_pin_minmax[1]);		// longitud del pin

x_arm=lim(x_arm_minmax[0],arm[1],x_arm_minmax[1]);				// medida del brazo: grosor
y_arm=lim(d_pin+1,arm[0],y_arm_minmax[1]);						// medida del brazo: fondo
armpit=lim(armpit_minmax[0],arm[2],armpit_minmax[1]);	// medida de la axila

d_hand=lim(d_hand_minmax[0],hand[0],d_hand_minmax[1]);
h_hand=lim(h_hand_minmax[0],hand[1],x_arm-0.5);
n_hand=lim(n_hand_minmax[0],2*floor(hand[2]/2),n_hand_minmax[1]);	// [4,6,8,10,12] nº de lados del polígono de la mano

z_arm=lim(y_arm+5+d_hand,arm[3],z_arm_minmax[1]);	// medida del brazo: longitud

// Volumen
difference(){
	union(){
		arm_quadrangle(arm=[y_arm,x_arm,z_arm],hand=hand);
		translate([0,0,x_arm])
			pyramid_circumscribed (d1=y_arm,d2=d_pin+3,h=armpit,n=4);
		}
	// Huecos hexagonales para introducir una espiga
	gap(gap=pin,deep=pin[1],play=play);
	translate([0,0,x_arm+armpit])rotate([180,0,0])
		gap(gap=pin,deep=pin[1],play=play);
	}
}


// -------------- Fin del módulo arm_union_quadrangle () -----------------
// ------------------------------------------------------------------------

//////////////////////////////////////////////////////////////////
///////////// MODULO arm_cylindrical()  //////////////////////////

module arm_cylindrical (	arm=[18,6,45],		// [d,h,l]
						hand=[27,4,120]		// [d,h,ang]
						){

// valores con límites: acotados entre un máximo y un mínimo (los valores límite están en <limits_oblobots.scad>)
d_arm=lim(d_arm_minmax[0],arm[0],d_arm_minmax[1]);			// medida del brazo: fondo
h_arm=lim(h_arm_minmax[0],arm[1],h_arm_minmax[1]);			// medida del brazo: ancho

d_hand=lim(d_hand_minmax[0],hand[0],d_hand_minmax[1]);
h_hand=lim(h_hand_minmax[0],hand[1],h_arm-0.5);
angle_hand=lim(angle_hand_minmax[0],hand[2]/2,angle_hand_minmax[1]);			//max(0,min(180,hand[2]/2));

l_arm=lim(d_arm+d_hand,arm[2],l_arm_minmax[1]);			// medida del brazo: longitud

// variables condicionadas a los valores de entrada
d_i_hand=d_hand/2;
d2_arm=d_arm-h_arm;
wrist=d_hand/3;
h_i_arm=h_arm/2;
l_i_arm=l_arm-d_arm/2-d_hand/2;

$fn=50;

// Volumen 
union(){
	difference(){
		union(){
			// brazo
			hull(){
				translate([0,0,h_arm-h_i_arm])
					cylinder(r=d_arm/2,h=h_i_arm);
				translate([0,0,0])
					cylinder(r=d2_arm/2,h=h_arm-h_i_arm);
				translate([l_i_arm-d_hand/2+wrist/2,0,0])
					cylinder(r=wrist/2,h=h_hand-1.5);
				}
			// mano
			translate([l_i_arm,0,0])
				cylinder(r1=d_hand/2,r2=(d_hand/2)*1,h=h_hand);
			}
			// hueco de la mano
			translate([l_i_arm,0,0])
				cylinder(r=d_i_hand/2,h=h_arm*2+2,center=true);
			// Garra
			for(i=[0,1]){
				mirror([0,i,0])		
					difference(){
						translate([l_i_arm,-0.01,-2])
							cube([d_hand,d_hand,2*h_arm-2]);
						translate([l_i_arm,0,-2])
							rotate([0,0,angle_hand])
								cube([d_hand,d_hand,2*h_arm-2]);
						}
				}
		}

	if(hand[2]>=180){
		for(i=[0,1]){
			mirror([0,i,0])
				translate([l_i_arm+d_hand/4,3*(d_hand-d_i_hand)/4,h_hand/2])
					cube([d_hand/2,(d_hand-d_i_hand)/2,h_hand],center=true);
			}
		}
	}
}

// -------------- Fin del módulo arm_cylindrical () -----------------------
// ------------------------------------------------------------------------


////////////////////////////////////////////////////////////////////////
/////////////////// MODULO arm_quadrangle()  ///////////////////////////

module arm_quadrangle (	arm=[10,15,70],		// [ grosor(x), fondo(y), longitud(z) ] Medidas de los Brazo
						hand=[20,5,8]
						){

x_arm=lim(x_arm_minmax[0],arm[1],x_arm_minmax[1]);					// medida del brazo: grosor
y_arm=lim(y_arm_minmax[0],arm[0],y_arm_minmax[1]);					// medida del brazo: fondo

d_hand=lim(d_hand_minmax[0],hand[0],d_hand_minmax[1]);
h_hand=lim(h_hand_minmax[0],hand[1],x_arm-0.5);
n_hand=lim(n_hand_minmax[0],2*floor(hand[2]/2),n_hand_minmax[1]);	// [4,6,8,10,12] nº de lados del polígono de la mano

z_arm=lim(y_arm+5+d_hand,arm[2],z_arm_minmax[1]);					// medida del brazo: longitud



//side=2*tan(180/tn)*td/2;		// medida del lado

wrist=2*(d_hand/2)*tan(180/max(6,n_hand));
h_wrist=h_hand-1;
z_i_arm=z_arm-(y_arm/2)-d_hand-(wrist/2);

translate([0,0,x_arm])
mirror([0,0,1])
union(){
	difference(){
		hull(){
			translate([0,0,x_arm/2])
				cube([y_arm,y_arm,x_arm],center=true);
			translate([z_i_arm,0,x_arm-h_wrist/2])
				cube([wrist,wrist,h_wrist],center=true);
			}
		// rebaje del hombro / forma poligonal
		//translate([0,0,x_arm/2+2])
			//prism_circumscribed (n=n_hand,d=2*y_arm/4,h=x_arm/2);
		}
	// Mano
	difference(){
		translate([z_i_arm+wrist/2+d_hand/2,0,x_arm-h_hand])
			prism_circumscribed (n=n_hand,d=d_hand,h=h_hand);
		translate([z_i_arm+wrist/2+d_hand/2,0,0])
			prism_circumscribed (n=n_hand,d=d_hand/2,h=x_arm*2);
		translate([z_i_arm+wrist/2+3*d_hand/4,0,x_arm])
			cube([d_hand/2+1,d_hand/3,2*x_arm],center=true);
		}
	}
}

// -------------- Fin del módulo arm_quadrangle() -------------------------------
// ------------------------------------------------------------------------------

module prism_circumscribed (	n=4,			// nº lados de la base del prisma
							d=20,		// diámetro del círculo donde se circunscribe el prisma
							h=10			// altura del prisma
							){
if(n%2==0){
	rotate([0,0,180/n])
		cylinder (r=d/2/cos(180/n), h=h, $fn=n);
	}
	else{
		rotate([0,0,90/n])
			cylinder (r=d/2/cos(180/n), h=h, $fn=n);
		}
}

module pyramid_circumscribed (	n=4,			// nº lados de la base de la pirámide	
								d1=20,		// diámetro del círculo-base donde se circunscribe la pirámide
								d2=0,		// diámetro del círculo-punta donde se circunscribe la pirámide
								h=10			// altura de la pirámide
								){
if(n%2==0){
	rotate([0,0,180/n])
		cylinder (r1=d1/2/cos(180/n), r2=d2/2/cos(180/n), h=h, $fn=n);
	}
	else{
		rotate([0,0,90/n])
			cylinder (r1=d1/2/cos(180/n), r2=d2/2/cos(180/n), h=h, $fn=n);
		}
}

module gap (gap=[6,20], deep=15, play=0){								
$fn=6;

h=gap[1];
d=gap[0]+0.25+play;

translate([0,0,-0.1])
	union(){
		pyramid_circumscribed (d1=d+2,d2=d,h=1,n=6);
		translate([0,0,0.9])
			prism_circumscribed (d=d,h=deep+0.1,n=6);
		}	
}

module pin_simple(	pin=[12,20],		// [d,h]	medidas generales del pin
					base=[0,0,0,0],			// [d1,d2,h,n] medidas y forma de la base. Opcional
					){
					
$fn=50;


dp=lim(4,pin[0],20);								// diámetro del pin
hp=lim(5,pin[1],30);								// longitud del pin
db1=lim(dp,base[0],100);							// diámetro de la base1
db2=lim(dp,base[1],db1);							// diámetro de la base2 si es =db1 es un prisma rectangular
hb=base[2];										// longitud de la base
nb=lim(4,base[3],50);								// lim:(4<-->50) nº de lados del prisma base	

hp1=1;											// rebaje de la punta
hp2=hp-hp1;

translate([0,0,hb])
	union(){
		cylinder(r=dp/2, h=hp2);
		translate([0,0,hp2])
			cylinder (r1=dp/2,r2=(dp-2)/2,h=hp1);
		if(hb==0){
				translate([0,0,-hb])
					pyramid_circumscribed(d1=db1,d2=db2,h=hb,n=0);
				}
			else{
				translate([0,0,-hb])
					pyramid_circumscribed(d1=db1,d2=db2,h=hb,n=nb);
				}
		}
}

