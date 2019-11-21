
module pipeholder()
define();

//custermizing data

//screw taper hole r
sth=40;

//screw hole r
shr=18;

//number of screws
ns =3;  //[2,3,4]

//inner_diameter
ind=280;

//outer diameter
od=343;

//fringe diameter
fd=600;

//fringe thickness
fth=60;

//cylinder hight
ch=340;

//taper depth
tdp=fth*2/3;

// screw hole offset
off= 360/ns;

//custermizing data end

//ignore valuable
$fn=48;
	translate([0, 0, 0]) {
		difference() {
                union(){                                                      //cylinder & fringe
		  translate([0, 0, fth]) cylinder(h = ch-fth, r =od/2);               //cylinder
          translate([0, 0, 00])cylinder(h = fth, r= fd/2); //fringe
                       }
		for (i = [0:(ns-1)]) { 		                                        //screw taper hole
			echo(360*i/ns, sin(360*i/ns)*(od/2+70), cos(360*i/ns)*(od/2+70));
			translate([sin(360*i/ns)*(od/2+70), cos(360*i/ns)*(od/2+70), fth/2])
				cylinder(h =tdp, r2=sth,r1=shr);
		                      }
		translate([0, 0, 50])                                                 // shaft 
			cylinder(h = ch-fth+25, r=ind/2);
		       for (i = [0:(ns-1)]) {                                         // screw hole
			echo(360*i/ns+off, sin(360*i/ns+off)*(od/2+70), cos(360*i/ns+off)*(od/2+70));
			translate([sin(360*i/ns+off)*(od/2+70), cos(360*i/ns+off)*(od/2+70), -1 ])
				cylinder(h=(fth-tdp)+20,r=shr);
		                             }
                     }
                              }
pipeholder();
