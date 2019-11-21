// hole diameter
holeDiameter=7;

// dimensions of T-slot in table
A=9.5; 
H1=5.5;
H2=7.5;
C=15;

// length of T-nut
nutLength=15;

// dimensions of flat side of included Mx nut
nutWidth=10;

// dimensions (height) of included Mx nut
nutHeight=6;

module tnut() {
  P=(C-A)/2;
  difference() {
    translate([-C/2,nutLength/2,0])
    rotate([90,0,0])
    linear_extrude (height=nutLength)
    polygon(points=[[0,0], [C,0], [C,H2], [C-P,H2], [C-P,H2+H1], [P,H2+H1], [P,H2], [0,H2]]);
    
    cylinder (h=H1+H2,d=holeDiameter);

    angle = 360/6;
	  cote = nutWidth * (1 / tan (angle));

    translate([0,0,nutHeight/2])
    union() {
      rotate([0,0,0]) cube([nutWidth,cote,nutHeight],center=true);
      rotate([0,0,angle]) cube([nutWidth,cote,nutHeight],center=true);
      rotate([0,0,2*angle]) cube([nutWidth,cote,nutHeight],center=true);
    }
  }
}

tnut();


