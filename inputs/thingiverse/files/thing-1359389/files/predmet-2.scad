H1=14;
H2=5;
H3=24;

C=70;
D=20;

A=15;
B=0;
E=5;

F=15;
I=25;
G=10;

//trikotnik
TA=0;
TB=0;
TD=0;
TXr=0;
TYr=0;
TZr=0;
TX=0;
TY=0;
TZ=15/2;

//kvader-luknja
L=0;
M=5;
KX=-10;
KY=-5;
KZ=0;
KXr=0;
KYr=0;
KZr=0;

//cilinder-luknja
CR=15;
CXr=0;
CYr=0;
CZr=0;
CX=0;
CY=0;
CZ=0;

max_d_luknje=sqrt(pow(C,2)+pow(E+D+I,2))*2;

difference(){
	translate([-C/2,-(E+D-I)/2,-max(H1,H2,H3)/2]){
		cube([C,D,H1]);
		translate([A,D,0]){
			cube([C-A-B,E,H2]);
		}
		translate([G,-I,0]){
			cube([C-G-F,I,H3]);
		}
	}

	#translate([CX,CY,CZ]){
		rotate([CXr,CYr,CZr]){
			cylinder(h=max_d_luknje,r=CR,center=true, $fn=100);
		}
	}
	
	#translate([KX,KY,KZ]){
		rotate([KXr,KYr,KZr]){
			cube([L,M,max_d_luknje],center=true);
		}
	}
}

if(TD>0)
rotate([TXr,TYr,TZr]){
translate([TX,TY,TZ]){
linear_extrude(height = TD, center = true, convexity = 10, twist = 0){
polygon(points=[[-TB/2,-TA/2],[TB/2,-TA/2],[-TB/2,TA]], paths=[[0,1,2]]);
}
}
}

