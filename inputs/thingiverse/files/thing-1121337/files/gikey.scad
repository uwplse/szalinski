Gykeysize=15;// [12:Small,15:Medium,17:Large]
lenghtGikey=14;// [12:Small,15:Medium,17:Large]
//size of the nozzle of the printer
nozzlesize=0.5;// [0.1:ReallySmall,0.1:Small,0.2:Medium,0.3:Ok,0.4:Large,0.5:ExtraLarge]
//The wall size is this times the nozzlesize
wallsizemul1and2=3;// [1:Thin,2:Ok,3:Large]
//The wall size of most internal is this times the nozzlesize
wallsizemult3=2;// [1:Thin,2:Ok,3:Large]
//Space between layers multiplier
Layers_Space=2.8;// [1:Thin,2:Ok,3:Large]

//Radious toroid 
rtoroid=1.05;

dstoroid=Gykeysize/2-2*rtoroid;//Radious circle of toroid

// ignore variable values
sizefirstring=(Gykeysize-(Layers_Space*nozzlesize))-(Layers_Space*nozzlesize);

// ignore variable values
sizesecondring=(sizefirstring-(Layers_Space*nozzlesize))-(Layers_Space*nozzlesize);

// ignore variable values
fares=1;
// ignore variable values
fsres=0.5;


//init thing
union(){
	intersection() {
		difference() {
			sphere(Gykeysize, $fa=fares, $fs=fsres);
			sphere(Gykeysize-(wallsizemul1and2*nozzlesize), $fa=fares, $fs=fsres);
		}
		cube(center = true,size = [2.5*Gykeysize,2.5*Gykeysize,15] );
	}
	difference() {	
		translate([0,Gykeysize,0])
			rotate([0,90,0])
			rotate_extrude($fn=100)
			translate([dstoroid,0,0])
			circle(r=2*rtoroid);
		sphere(Gykeysize, $fa=fares, $fs=fsres);
	}
}

intersection() {
	difference() {
		sphere(sizefirstring, $fa=fares, $fs=fsres);
		sphere(sizefirstring-(wallsizemul1and2*nozzlesize), $fa=fares, $fs=fsres);
	}
	cube(center = true,size = [2.5*Gykeysize,2.5*Gykeysize,15] );
}

intersection() {
	difference() {
		sphere(sizesecondring, $fa=fares, $fs=fsres);
		sphere(sizesecondring-(wallsizemult3*nozzlesize), $fa=fares, $fs=fsres);
	}
	cube(center = true,size = [2.5*Gykeysize,2.5*Gykeysize,15] );
}
