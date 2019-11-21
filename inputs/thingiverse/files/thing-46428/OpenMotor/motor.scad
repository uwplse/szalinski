$fn = 100;

pi = 3.14159;


armature_spindle_radius = 2;
armature_spindle_length = 10;
armature_radius = 10; // radius of center armature
armature_length = 20; // total height or length of the armature and stator
armature_clearance = 0.7; // clearance from armature to stator

stator_thickness = 5; //thickness dedicated to windings in the stator
form_thickness=2; // thickness of the forms for the stator

tslot_height1 = 5;
tslot_width1 = 5;
tslot_height2 = 5;
tslot_width2 = 10;
tslot_clearance = 0.5;
tslot_carrier_thickness = 2;
endplate_thickness = 2;
armature_spindle_clearance = 0.5;
scallop_radius = 50;

slice_angle_thickness = (0.5) *180/(pi*(armature_radius+armature_clearance));  // (mm) *180/(pi*r), distance between closest forms 

// correction factor for tslots
//echo(((armature_radius+armature_clearance+2*form_thickness+stator_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness)*cos(asin(tslot_width1/((armature_radius+armature_clearance+2*form_thickness+stator_thickness)*2)))));

// create endplates
translate([0,0,0]) endplate();
$translate([0,0,armature_length]) rotate([180,0,0]) endplate();

// armature size
translate([0,0,0]) union()
{
  cylinder(r=armature_radius, h=armature_length);  // for fun, plot the armature
  translate([0,0,-endplate_thickness]) cylinder(r=armature_spindle_radius, h = endplate_thickness);
  translate([0,0,armature_length]) cylinder(r=armature_spindle_radius, h = endplate_thickness+armature_spindle_length);
}

// forms
union()
{
  armature();
  
  linear_extrude(height=armature_length)
  {
    rotate([0,0,90]) 
    {
      translate([0,armature_radius+armature_clearance+2*form_thickness+stator_thickness-((armature_radius+armature_clearance+2*form_thickness+stator_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness)*cos(asin(tslot_width1/((armature_radius+armature_clearance+2*form_thickness+stator_thickness)*2))))]) 
      {
	tslot(w1= tslot_width1, h1 = tslot_height1, w2 = tslot_width2, h2=tslot_height2);
      }
    }
  }
  
  linear_extrude(height=armature_length)
  {
    rotate([0,0,90+120]) translate([0,armature_radius+armature_clearance+2*form_thickness+stator_thickness-((armature_radius+armature_clearance+2*form_thickness+stator_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness)*cos(asin(tslot_width1/((armature_radius+armature_clearance+2*form_thickness+stator_thickness)*2))))]) tslot(w1= tslot_width1, h1 = tslot_height1, w2 = tslot_width2, h2=tslot_height2);
  }
  
  linear_extrude(height=armature_length)
  {
    rotate([0,0,90-120]) translate([0,armature_radius+armature_clearance+2*form_thickness+stator_thickness-((armature_radius+armature_clearance+2*form_thickness+stator_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness)*cos(asin(tslot_width1/((armature_radius+armature_clearance+2*form_thickness+stator_thickness)*2))))]) tslot(w1= tslot_width1, h1 = tslot_height1, w2 = tslot_width2, h2=tslot_height2);
  }
}


// generate end plate
module endplate()
{
  union()
  {
    // endplate
    translate([0,0,-endplate_thickness]) linear_extrude(height=endplate_thickness)
    difference()
    {
      circle(r=armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness);
      // spindle hole
      circle(r=armature_spindle_radius+armature_spindle_clearance);
      
      // scallops
      translate([(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)+((scallop_radius*cos(asin((armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)/scallop_radius*sin(60-((tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)*180/(2*pi*(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)))))))-((armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)*cos(60-((tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)*180/(2*pi*(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)))))),0]) circle(r=scallop_radius);
      // scallops
      rotate([0,0,120]) translate([(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)+((scallop_radius*cos(asin((armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)/scallop_radius*sin(60-((tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)*180/(2*pi*(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)))))))-((armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)*cos(60-((tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)*180/(2*pi*(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)))))),0]) circle(r=scallop_radius);
      // scallops
      rotate([0,0,-120]) translate([(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)+((scallop_radius*cos(asin((armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)/scallop_radius*sin(60-((tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)*180/(2*pi*(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)))))))-((armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)*cos(60-((tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)*180/(2*pi*(armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness)))))),0]) circle(r=scallop_radius);
    }

    // tslot carriers
    rotate([0,0,90]) linear_extrude(height=armature_length/2)
    {
      intersection()
      {
	translate([0,armature_radius+armature_clearance+2*form_thickness+stator_thickness-((armature_radius+armature_clearance+2*form_thickness+stator_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness)*cos(asin(tslot_width1/((armature_radius+armature_clearance+2*form_thickness+stator_thickness)*2))))])
	{
	  difference()
	  {
	    translate([-(tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)/2,0]) square([tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness, tslot_height1+tslot_height2+tslot_clearance+tslot_carrier_thickness]);
	    tslot(w1= tslot_width1+tslot_clearance*2, h1 = tslot_height1-tslot_clearance, w2 = tslot_width2+2*tslot_clearance, h2=tslot_height2+2*tslot_clearance);
	  }
	}
	
	circle(r=armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness);
      }
    }

    rotate([0,0,90-120]) linear_extrude(height=armature_length/2)
    {
      intersection()
      {
	translate([0,armature_radius+armature_clearance+2*form_thickness+stator_thickness-((armature_radius+armature_clearance+2*form_thickness+stator_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness)*cos(asin(tslot_width1/((armature_radius+armature_clearance+2*form_thickness+stator_thickness)*2))))])
	{
	  difference()
	  {
	    translate([-(tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)/2,0]) square([tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness, tslot_height1+tslot_height2+tslot_clearance+tslot_carrier_thickness]);
	    tslot(w1= tslot_width1+tslot_clearance*2, h1 = tslot_height1-tslot_clearance, w2 = tslot_width2+2*tslot_clearance, h2=tslot_height2+2*tslot_clearance);
	  }
	}
	
	circle(r=armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness);
      }
    }

    rotate([0,0,90+120]) linear_extrude(height=armature_length/2)
    {
      intersection()
      {
	translate([0,armature_radius+armature_clearance+2*form_thickness+stator_thickness-((armature_radius+armature_clearance+2*form_thickness+stator_thickness)-(armature_radius+armature_clearance+2*form_thickness+stator_thickness)*cos(asin(tslot_width1/((armature_radius+armature_clearance+2*form_thickness+stator_thickness)*2))))])
	{
	  difference()
	  {
	    translate([-(tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness)/2,0]) square([tslot_width2+2*tslot_clearance+2*tslot_carrier_thickness, tslot_height1+tslot_height2+tslot_clearance+tslot_carrier_thickness]);
	    tslot(w1= tslot_width1+tslot_clearance*2, h1 = tslot_height1-tslot_clearance, w2 = tslot_width2+2*tslot_clearance, h2=tslot_height2+2*tslot_clearance);
	  }
	}
	
	circle(r=armature_radius+armature_clearance+2*form_thickness+stator_thickness+tslot_height1+tslot_height2+tslot_carrier_thickness);
      }
    }
  }
}


module armature()
{

  // stator
  difference()
  {
    linear_extrude(height = armature_length) // extrude the 2d form
    {
      union() // connect the inner ring form, stator center and outer ring form
      {
	difference() // generate the 2d cross section of the stator center (where the wire is wound)
	{
	  ring(r2=(armature_radius+armature_clearance+stator_thickness+2*form_thickness), r1 = (armature_radius+armature_clearance));
	  
	  // slices out of the ring that form 2d cross section of the winding area
	  kees_unit_angle_slice(2*(slice_angle_thickness+stator_thickness *180/(pi*(armature_radius+armature_clearance+form_thickness))),armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	  rotate([0,0,120]) kees_unit_angle_slice(2*(slice_angle_thickness+stator_thickness *180/(pi*(armature_radius+armature_clearance+form_thickness))),armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	  rotate([0,0,-120]) kees_unit_angle_slice(2*(slice_angle_thickness+stator_thickness *180/(pi*(armature_radius+armature_clearance+form_thickness))),armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	}

	difference() // inner ring form
	{
	  ring(r1=(armature_radius+armature_clearance), r2=(armature_radius+armature_clearance+form_thickness));

	  kees_unit_angle_slice(slice_angle_thickness,armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	  rotate([0,0,120]) kees_unit_angle_slice(slice_angle_thickness,armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	  rotate([0,0,-120]) kees_unit_angle_slice(slice_angle_thickness,armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	}

	difference() // outer ring form
	{
	  ring(r1=(armature_radius+armature_clearance+form_thickness+stator_thickness), r2=(armature_radius+armature_clearance+stator_thickness+2*form_thickness));

	  kees_unit_angle_slice(slice_angle_thickness,armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	  rotate([0,0,120]) kees_unit_angle_slice(slice_angle_thickness,armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	  rotate([0,0,-120]) kees_unit_angle_slice(slice_angle_thickness,armature_radius+armature_clearance+stator_thickness+2*form_thickness);
	}
      }
    }

    // form cut lower ring, extrude and difference from bottom and top of form
    // bottom
    translate([0,0,-1])
    {
      linear_extrude(height = stator_thickness+1)
      {
	ring(r2=(armature_radius+armature_clearance+stator_thickness+form_thickness), r1 = (armature_radius+armature_clearance+form_thickness));
      }
    }
    
    // top
    translate([0,0,armature_length-stator_thickness])
    {
      linear_extrude(height = stator_thickness+1)
      {
	ring(r2=(armature_radius+armature_clearance+stator_thickness+form_thickness), r1 = (armature_radius+armature_clearance+form_thickness));
      }
    }
  }
}


// create a wedge, up to 90 degrees for use with creating slices
module kees_unit_angle_slice(angle_width, radius)
{
  polygon(points=[[0,0], [2*radius, 2*radius*sin(angle_width/2)], [2*radius, -2*radius*sin(angle_width/2)]]);
}

// ring starting at r1 and going to r2
module ring(r1, r2)
{
  difference()
  {
    circle(r=r2);
    circle(r=r1);
  }
}

//tslot(w1= 5, h1 = 5, w2 = 10, h2=5);

// t-slot
//  ----width2---- ] height2
//        |
//     width1      ] height1
//        |
module tslot(w1, h1, w2, h2)
{
  translate([-w1/2,0]) square([w1,h1]);
  translate([-w1/2-(w2-w1)/2,h1]) square([w2,h2]);
}


