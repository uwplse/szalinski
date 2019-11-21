

HolesDistance = 194;
HolesSize = 2.7;

/* [Hidden] */

BD1=8;
BD2=24;
BR=1.5;
BH=20;

module BaseBlock(){
	difference(){
		union(){
			translate([0,0,BH-BR/2]){
				cube([BD1-2*BR,BD2+2*BR,BR],center=true);
				for (i=[-1,1]){
					translate([i*BD1/2,0,0])
						cube([2*BR,BD2-2*BR,BR],center=true);
					for (j=[-1,1]){
						translate([i*(BD1/2-BR),j*(BD2/2-BR),0])
							cylinder (r1=BR,r2=2*BR, h=BR,center=true);
					}
				}
			}
			translate([-BD1/2+BR,-BD2/2,0]){
				cube([BD1-2*BR,BD2,BH]);
			}
			for (i=[-1,1]){
				translate([i*(BD1/2-BR/2)-BR/2,-(BD2-2*BR)/2,0])
					cube([BR,BD2-2*BR,BH]);
				for (j=[-1,1]){
					translate([i*(BD1/2-BR),j*(BD2/2-BR),0])
						cylinder (r=BR, h=BH);
				}
			}
		}
		for (i=[-1,1]){
			translate([i*(BD1/2+BR),-BD2/2-BR-.5,BH-BR])
				rotate([-90,0,0])
					cylinder(r=BR,h=BD2+2*BR+1);
		}
		for (i=[-1,1]){
			translate([(BD1/2+BR+.5),i*(-BD2/2-BR),BH-BR])
				rotate([0,-90,0])
					cylinder(r=BR,h=BD1+2*BR+1);
		}
		translate([0,0,BH/2])
			cylinder(d=HolesSize,h=BH+1,center=true);
	}
}

module Banana(L=200,T=20,H=5,f=1.5){
	Tck=H;
	C2=T/2.0;
	Alpha=atan(L/(2*C2));
	Beta=180-2*Alpha;
	R=L/(2*sin(Beta));
	intersection(){
		translate([0,1*(R-C2),0])
			smothCylinder(r=R,h=Tck,f=f);
		translate([0,-1*(R-C2),0])
			smothCylinder(r=R,h=Tck,f=f);
	}

}

module smothCylinder(r=20,h=20,f=2,center=false){
	TR=(center==true)? -h/2 : 0;	
	translate([0,0,TR])
		rotate_extrude(){
			union(){
				square([r-f,h]);
				translate([r-f,f,0])
					square([f,h-2*f]);
				for (i=[0,1]) translate([r-f,f+i*(h-2*f),0]) circle(r=f);
			}
		}
}

module Body(){
	module BananaSplit(){
		difference(){
			Banana(L=90,T=17,H=6);
			translate([0,-9,-.5])
				cube([45,18,7]);
		}
	}
	union(){
		Banana(L=HolesDistance+90,T=17,H=6);
		translate([0,0,3]) rotate([0,90,0]) rotate([0,0,90])
		union(){
			cube([13,2*BR,HolesDistance+90],center=true);
			for (i=[1,-1]){
				translate([0,i*2.25,0])
					cube([10,BR,HolesDistance+90],center=true);

				for (j=[1,-1]){
					translate([i*(10/2),j*BR,0])
						cylinder(r=BR,h=HolesDistance+90,center=true);
				}
			}
		}
		for (i=[0,180])
			rotate([0,0,i])
				translate([HolesDistance/2+45,0,0])
					BananaSplit();
		for (i=[1,-1])
			translate([i*(HolesDistance/2+45),0,2*BR])
				rotate([0,90,0])
					EndCap(L=6,C=17,f=BR);
	}
	
}

module WholeAssembly(){
	union(){
		translate([0,0,BH])
			Body();
		for (i=[1,-1])
			translate([i*HolesDistance/2,0,0])
				rotate([0,0,90])
					BaseBlock();
	}
}

module EndCap(L=20,C=10,f=2){
	union(){
		cube([L-2*f,C-2*f,2*f],center=true);
		for (i=[1,-1]){			
			translate([0,i*(C/2-f),0])
				rotate([0,90,0])
					cylinder(r=f,h=L-2*f,center=true);
			translate([i*(L/2-f),0,0])
				rotate([90,0,0])
					cylinder(r=f,h=C-2*f,center=true);
			for (j=[1,-1]){
				translate([i*(L/2-f),j*(C/2-f),0])
					sphere(r=f);
			}
		}
		
	}
	
}

//BaseBlock();
//Body($fa=1);
WholeAssembly($fa=1,$fs=.1);
//smothCylinder($fa=1,$fs=.5,center=true);
//EndCap($fa=1,$fs=.2);