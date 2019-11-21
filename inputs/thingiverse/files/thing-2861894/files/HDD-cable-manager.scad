/* 
 HDD cable manager --
 Pierre Delore - pierre@techandrun.com
 CC-BY-SA
*/

// preview[view:north east, tilt:top diagonal]

// variable description

//Total length of the part (in mm)
length=70; //[20:200] 
//Cable diameter (in mm). Add at least 0.5mm of play.
cable_diameter=6.0; //[1:0.5:20]
//Width of the part (in mm)
width=15; //[1:50]
//Tickness of the walls (in mm)
tickness=2.5; //[1:0.5:20]
//Slot width to insert the cable (in mm). Minimum: The cable diameter.
cable_insert_width=7.5;  //[1:0.5:20] 
//Tickness of the middle wall (in mm)
middle_wall_tickness=3; //[1:10]  

/* [Hidden] */
//Internal variables
$fn=64;
ep=0.01;
ep2=0.02;

attache_size=6;
height=cable_diameter+tickness*2;


//Round box on all sides
module roundbox_all(wx, wy, wz, radius) {
	hull() {
        translate([radius, radius, radius])
			sphere(r=radius);

		translate([radius, radius, wz-radius])
			sphere(r=radius);

        //--
		translate([wx-radius, radius, radius])
			sphere(r=radius);

		translate([wx-radius, radius, wz-radius])
			sphere(r=radius);

        //--
		translate([wx-radius, wy-radius,radius])
			sphere(r=radius);

		translate([wx-radius, wy-radius, wz-radius])
			sphere(r=radius);

        //--
		translate([radius,wy-radius,radius])
			sphere(r=radius);

		translate([radius, wy-radius, wz-radius])
			sphere(r=radius);
	}
}


//Go!
difference() {
  union() {
    //Top body
    translate([attache_size,0,0])
      roundbox_all(length-(attache_size*2),height,width,2);
    //Bottom body
    roundbox_all(length,height-5,width,2);
  }

  //Calculate slot size
  sl=(length-(attache_size*2)-(tickness*2)-middle_wall_tickness)/2;

  //Left slot to store the cable
  translate([attache_size+tickness, tickness,-2])
    roundbox_all(sl, height-(tickness*2), width+2+2,2);
  //Right slot to store the cable
  translate([attache_size+tickness+sl+middle_wall_tickness, tickness, -2])
    roundbox_all(sl, height-(tickness*2), width+2+2,2);

  //Left slot to insert the cable
  translate([attache_size+tickness+sl-cable_insert_width-middle_wall_tickness, height-tickness-1,-ep])
    cube([cable_insert_width, tickness+2, width+ep2]);

  //Right slot to insert the cable
  translate([attache_size+tickness+sl+(middle_wall_tickness*2), height-tickness-1,-ep])
    cube([cable_insert_width, tickness+2, width+ep2]);

  //Left rubber band slot
  r=1.75; //Radius of the rubber cylinder
  a=2.5; //Width of rubber slot (smaller than the "r*2")
  translate([attache_size-a, tickness+r,-ep])
    cube([a, height, width+ep2]);
  translate([attache_size-r, tickness+r,-ep])
    cylinder(d=r*2,h=width+ep2);
  
  //Top left chamfer
  translate([attache_size-r, tickness+r, width-1])
    cylinder(d1=r*2-1,d2=r*2+2,h=2);
  //Bottom left chamfer
  translate([attache_size-r, tickness+r, -1])
    cylinder(d1=r*2+2,d2=r*2-1,h=2);

  //Right rubber band slot
  translate([length-attache_size, tickness+r,-ep])
    cube([a, height, width+ep2]);
  translate([length-attache_size+r, tickness+r,-ep])
    cylinder(d=r*2,h=width+ep2);

  //Top right chamfer
  translate([length-attache_size+r, tickness+r, width-1])
    cylinder(d1=r*2-1,d2=r*2+2,h=2);
  //Bottom right chamfer
  translate([length-attache_size+r, tickness+r, -1])
    cylinder(d1=r*2+2,d2=r*2-1,h=2);
}