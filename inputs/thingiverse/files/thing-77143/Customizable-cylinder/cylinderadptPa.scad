
//inner diameter
ind =44; // [0:100]

//outer diameter bottom 
od1=57; //[0:100]

//outer diameter top 
od2=56; //[0:100]

//fringe diameter
fd=66; //[0:100]

//fringe thickness
fth=2; //[0:10]

//cylinder hight 
ch=100; //[0:1000]

translate([0, 0, 0]) {
					union() {
					difference() {
                						union(){                         //cylinder & fringe
		  translate([0, 0, fth]) cylinder(h = ch-fth, r1 =od1/2,r2=od2/2,$fn=96);  //cylinder
          translate([0, 0,0])cylinder(h = fth, r= fd/2,$fn=96); 						//fringe
												}
		translate([0, 0, -1])                                                 // shaft 
			cylinder(h = ch+2, r= ind/2, $fn=96);
		translate([0, 0, 0])                                                 // shaft 
			cylinder(h =3, r= ind/2+3, $fn=96);                
                			     }
//Upper Ring
translate([0, 0,ch])
rotate_extrude(convexity = 10, $fn = 48)
translate([(ind+od2)/4, 0,0])
circle(r = (od2-ind)/4, $fn = 48);

//Bottom Ring
translate([0, 0, (od1-ind)/4])
rotate_extrude(convexity = 10, $fn = 48)
translate([(ind+od1)/4, 0,0])
circle(r = (od1-ind)/4, $fn = 48);
							}
					}

