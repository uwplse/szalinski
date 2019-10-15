// Diameter of the routerbit
router=8;
// Diameter of the guide bushing
bushing = 10.8 + 0.1;
delta = bushing - router;

// Width of the dovetail at the wider end
dovewide = 30;
// Width of the dovetail at the narrower end
dovenarrow = 15;
// Depth of the dovetail
dovedept = 30;

// Width of the baseplate
basewidth = 80;
// Length of the baseplate
baselength = 70;

// Thickness of the template
templatethickness = 10;

// Width of the material
materialwidth = 50;
// Thickness of the material
materialthickness = 25;

// Screwshaft
screwshaft = 5.1;
// Diameter of the screwhead
screwheaddiameter = 16;
// Legnth of the Screwhead
screwheadlength = 7;
// Size of the pocket for the nut
nutparallelwidth = 8.0;
// Diagnal measurement of the nut
nutdiagonalwidth = 8.8;
// Thickness of the nut
nutthickness = 4.1;

// Shoulder
offset = 10;


// Size of the screwblocks
screwblocksize = (basewidth-materialwidth) / 2;


difference() {

  union() {

    translate([0,0,0]) {

        hull() {
          translate([-0.5*dovenarrow,-0.5*(router-delta),0]) cylinder(d=router-delta, h=templatethickness);
          translate([0.5*dovenarrow,-0.5*(router-delta),0]) cylinder(d=router-delta, h=templatethickness);
          translate([-0.5*dovewide,dovedept,0]) cylinder(d=router-delta, h=templatethickness);
          translate([0.5*dovewide,dovedept,0]) cylinder(d=router-delta, h=templatethickness);
        }

        translate([-0.5*basewidth,-baselength,0]) cube([basewidth,baselength,templatethickness]);

    }

    translate([materialthickness, -3*nutdiagonalwidth-offset, 0])
      difference() {
        cube([screwblocksize,3*nutdiagonalwidth, 0.5*materialthickness+templatethickness]);
        translate([0.5*screwblocksize,1.5*nutdiagonalwidth,0.25*materialthickness+templatethickness]) cube([1.1*screwblocksize,nutparallelwidth,nutthickness], center=true);
    }

    translate([-materialthickness-screwblocksize, -3*nutdiagonalwidth-offset, 0])
      difference() {
        cube([screwblocksize,3*nutdiagonalwidth, 0.5*materialthickness+templatethickness]);
        translate([0.5*screwblocksize,1.5*nutdiagonalwidth,0.25*materialthickness+templatethickness]) cube([1.1*screwblocksize,nutparallelwidth,nutthickness], center=true);
    }

  }

  translate([materialthickness, -3*nutdiagonalwidth-offset, 0])
      translate([0.5*screwblocksize,1.5*nutdiagonalwidth]) cylinder(d=screwshaft,h=1.1*(0.5*materialthickness+templatethickness));


  translate([-materialthickness-screwblocksize, -3*nutdiagonalwidth-offset, 0])
      translate([0.5*screwblocksize,1.5*nutdiagonalwidth]) cylinder(d=screwshaft,h=1.1*(0.5*materialthickness+templatethickness));

}

// Here comes the negative form

radius = 0.5 * (router-delta);
dy = (radius+delta);

angle = atan(((dovewide-dovenarrow)/2)/dovedept);
d1 = tan(angle) * dy;
dx = dovenarrow/2 +radius + 2*delta +d1;

translate([0,0,templatethickness]) mirror([0,0,1])
difference() {

  translate([-0.5*basewidth,delta,0]) cube([basewidth,baselength,templatethickness]);

    hull() {
      translate([-0.5*dovenarrow,-0.5*(router-delta),-0.1]) cylinder(d=router+delta, h=templatethickness*1.1);
      translate([0.5*dovenarrow,-0.5*(router-delta),-0.1]) cylinder(d=router+delta, h=templatethickness*1.1);
      translate([-0.5*dovewide,dovedept,-0.1]) cylinder(d=router+delta, h=templatethickness*1.1);
      translate([0.5*dovewide,dovedept,-0.1]) cylinder(d=router+delta, h=templatethickness*1.1);
    }

    translate([dx,dy,-0.1]) difference() {
        translate([-2*radius,-2*radius,0]) cube([2*radius,2*radius,templatethickness*1.1]);
        cylinder(r=radius, h=templatethickness*1.1);
    }

    translate([-dx,dy,-0.1]) difference() {
        translate([0,-2*radius,0]) cube([2*radius,2*radius,templatethickness*1.1]);
        cylinder(r=radius, h=templatethickness*1.1);
    }


    // Create the holes and the block to screw the 2 parts together
    translate([-materialthickness-0.5*screwblocksize,delta+1.5*nutdiagonalwidth,0]) union() {
      cylinder(d=screwheaddiameter, h=screwheadlength);
      cylinder(d=screwshaft, h=templatethickness*1.1);
    }
    translate([materialthickness+0.5*screwblocksize,delta+1.5*nutdiagonalwidth,0]) union() {
      cylinder(d=screwheaddiameter, h=screwheadlength);
      cylinder(d=screwshaft, h=templatethickness*1.1);
    }


}
