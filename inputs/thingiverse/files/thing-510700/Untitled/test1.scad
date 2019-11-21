// ajuste de qualidade
//$fa=1; // minimo angulo
//$fs=0.01; // minimo segmento
//$fn=36;

//relativo ao material
// espessura do material
thick=4; 

// borda necessária para montagem
reserva=5;

// largura total
width=100;
 
// extensão para estabilidade
extra=30; 

// altura do primeiro apoio
height_1=20;

// altura do segundo apoio
height_2=10; 

// encaixes do primeiro apoio
qt_slot_1=5; 


// encaixes do segundo apoio
qt_slot_2=4;

// espaço entre paredes
between=3; 

// proportion taken by each slot relative to total depth
base_slot = 1/4; 

// altura extra para evitar fragilidade da base
neck = 3; 

//angulo das cartas
theta = 10; 

//calculo intermediario
radius=min(between,reserva); // raio da borda arredondada
fit=0.1+abs(height_1-height_2); // para evitar problemas no difference

ext_norm=max(extra,reserva);
h_base=ext_norm+thick+between+thick+reserva;
h_p2=height_2+thick;
h_p1=height_1+thick;
hb = h_base*sin(theta);
slot_w = base_slot*h_base;
slot_h = 0.1+hb+neck+thick;	

linear_extrude(height = thick){
//base
difference(){
	square([width,h_base]);
	
	translate([0,reserva,0])
		encaixes(largura=width, altura=thick, qt=qt_slot_2, borda=reserva+thick);
	translate([0,reserva+between+thick,0])
		encaixes(largura=width, altura=thick, qt=qt_slot_1, borda=reserva+thick);
//desenhar os encaixes da lateral
	translate([reserva,slot_w/2,0])
		square([thick,slot_w+0.2/**/]);
	translate([width-thick-reserva,slot_w/2,0])
		square([thick,slot_w+0.2/**/]);
	translate([reserva,h_base-slot_w/2,0])
		square([thick,slot_w/2+0.2/**/]);
	translate([width-thick-reserva,h_base-slot_w/2,0])
		square([thick,slot_w/2+0.2/**/]);

}

// segundo apoio
translate([0,h_base+thick,0])
	parede (height_2,qt_slot_2);


// primeiro apoio
translate([0,h_base+thick+h_p2+thick,0])
	parede (height_1,qt_slot_1);

// laterais
rotate (-90) translate([-h_base,width+thick,0])
	lateral();
rotate (-90) translate([-(h_base+thick),width+thick,0]) mirror([1,0,0]) 
	lateral();
}
///////////////////////////////////////////////////////////////////
module lateral () {
	
//	polygon(points = [[h_base,0],[0,h_base*sin(theta)],[h_base,h_base*sin(theta)]]);
	difference() {
		union(){
			polygon(points = [[h_base,0],[0,h_base*sin(theta)],[h_base,h_base*sin(theta)]]);
			translate([0,hb,0]) 
				apoio(largura=h_base/*ext_norm+reserva+thick+between+thick/**/, altura=neck+thick+reserva, raio=radius);
			// lateral
			translate([ext_norm-reserva,neck+thick+hb,0])
				apoio(largura=reserva+thick+between, altura=height_1, raio=between);
			translate([ext_norm+thick,neck+thick+hb,0])
				apoio(largura=between+thick+reserva, altura=height_2, raio=between);
		};
	// aplicar encaixes na junção da peça
		translate([ext_norm-reserva,neck+thick+hb,0])
			fenda (xx=reserva, altura=height_1, parede=thick, baixo=false);
		translate([ext_norm+thick,neck+thick+hb,0])
			fenda (xx=between, altura=height_2, parede=thick, baixo=false);
		translate([slot_w,-(0.1),0])
			square([h_base-2*slot_w,slot_h]);
		translate([slot_w/2,hb+neck,0])
			square([slot_w/2+0.1,thick]);
		translate([h_base-slot_w/2,hb+neck,0])
			square([slot_w/2+0.1,thick]);
	}
}

module parede(hh,nn) {
	union(){
		encaixes(largura=width, altura=thick, qt=nn, borda=reserva+thick);
		translate([0,thick,0])
			difference() {
				apoio(largura=width, altura=hh, raio=radius);
				fendas_apoio(largura=width,altura=hh, parede=thick, borda=reserva);
			}
	}
}

module fendas_apoio(largura, altura, parede, borda=0, baixo=true) {

	fenda (xx=borda, altura=altura, parede=parede, baixo=baixo);
	fenda (xx=largura-borda-parede, altura=altura, parede=parede, baixo=baixo);
	
}

///////////////////////////////////////////////////////////////////
module apoio(largura, altura, raio=1) {
	hull(){
		square(size=[largura,0.01],center=false);
	//cortar os circulos?
		translate([raio,altura-raio,0])circle(r=raio);
		translate([largura-raio,altura-raio,0])circle(r=raio);
	}
}

module encaixes (largura, altura, qt=1, proporcao=0.5, borda=0) {
	total=largura-2*borda;
	passo=total/qt;
	for (i=[0:passo:total]){
		if (i < total) {
			translate([borda+i+passo/2,altura/2,0])square(size=[passo*proporcao,altura],center=true);
		}
	}
} 

module fenda(xx, altura, parede, baixo=true) {
	
	yy=baixo?-fit:altura/2;

	translate([xx,yy,0]) square(size=[parede,altura/2+fit],center=false);

}

