/*[Global] */
// Length
h0=80; // [50:200] 
//Radius
r2=20; //[7:50] 
//wall thickness
th=2.5; //[1:thin,2.5:normal,4:strong]

/* [Hidden]*/
$fn=90;
overlap=1;
h1=h0/2+overlap; //large funnel
h2=h0/2; //output length
r1=r2-1.5; //large radius
r3=r2-1.5; //small radius


difference(){
union(){
	cylinder(h=h1,r1=r1,r2=r2);
	translate([0,0,h1-overlap])	cylinder(h=h2,r1=r2,r2=r3);

//lower rings
	translate([0,0,6]) cylinder(h=5,r1=r1,r2=r1+1.5);
	translate([0,0,12]) cylinder(h=5,r1=r1,r2=r1+1.5);
	translate([0,0,18]) cylinder(h=5,r1=r1,r2=r1+1.5);
//upper rings
	translate([0,0,h1+h2-11]) cylinder(h=5,r1=r3+1.5,r2=r3);
	translate([0,0,h1+h2-17]) cylinder(h=5,r1=r3+1.5,r2=r3);
	translate([0,0,h1+h2-23]) cylinder(h=5,r1=r3+1.5,r2=r3);
}
	translate([0,0,0]) cylinder(h=h1,r1=r1-th,r2=r2-th);
	translate([0,0,h1-overlap])	cylinder(h=h2,r1=r2-th,r2=r3-th);
}

