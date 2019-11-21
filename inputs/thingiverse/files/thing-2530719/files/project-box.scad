
/* [Dimensions] */

//How to render the view
part = "composite"; // [top:Top only,bottom:Bottom Only,both:Both (printable),composition:Both (preview)]

//Outer width of the box
width = 50;

//Outer depth of the box
depth = 70;

//Outer height of the box
height = 35;

/* [Extra] */

//Wall thickness
thickness = 1.8;

//Height of the overlaping sections
overlap = 6;

/* [Vents] */

//Type of the vent hole
vent_type = "circle"; //[circle:Circular vents,square:Squared vents]

//Angle of the vent pattern
vent_angle = 45; //[0:89]

//Width of the vent ribbs (set to 0 to disable vents)
vent_w = 1; //[0:0.1:10]

//Space between vent ribbs (set to 0 for solid hole)
vent_spc = 2; //[0:0.1:10]

module half_box(width=70, depth=70, height=25, thickness=1.8, overlap=6) {
    
  difference() {
    //body
    cube([width,depth,height]);
      
    union() {
      //inner space
      translate([thickness,-1,thickness])
        cube([width-2*thickness,depth+2,height]);

      //chamfering
      x = sqrt(2)*width/2;
      translate([width/2,0,0])
      translate([0,0,thickness+height/2]) {
        rotate([0,0,45])
          cube([x,x,height], center=true);
      
        translate([0,depth,0])
        rotate([0,0,45])
          cube([x,x,height], center=true);
      }
      
      //vents
      translate([thickness,2*thickness,-1])
        inverted_vents(width-2*thickness, depth-4*thickness, thickness+2);
    }
      
  }
  
  //overlaps
  overlap = min(overlap, height/2-thickness);
  translate([thickness/2,thickness,thickness])
    cube([width-thickness,thickness,overlap]);  
  translate([thickness/2,depth-2*thickness, thickness])
    cube([width-thickness,thickness,overlap]);  
}

module inverted_vents(width=70, depth=70, height=1.8, angle=vent_angle, ribb_w=vent_spc, ribb_spc=vent_w) {


    x_spc = (ribb_w + ribb_spc) / cos(angle);    
    y=(depth+ribb_w)/cos(angle)+ribb_w;
    x_max = width + tan(angle) * depth;

    difference() {
        if (vent_type == "circle") {
           translate([width/2,depth/2,0])
             cylinder(d=min(width,depth), h=height);
        } else {
           cube([width,depth,height]);
        }
    
        for (x = [0: x_spc : x_max]) {    
            translate([x,0,0])    
            rotate([0,0,angle])
            translate([0,-ribb_w*tan(angle),-1])
                cube([ribb_w,y,height+2]);
        }
    }
}


module bottom() {
  half_box(width, depth, height, thickness, overlap);
}

module top() {
  rotate([0,0,90])
    half_box(depth, width, height, thickness, overlap);
}

module both() {
   top();
   translate([thickness,0,0])
     bottom();
}

module composite() {
  half_box(width, depth, height, thickness, overlap);    
    
  translate([0,0,2*height+thickness])
  rotate([180,0,90])
    half_box(depth, width, height, thickness, overlap);
}

module print_part() {
    if (part == "top") {
        top();
    } else if (part == "bottom") {
        bottom();
    } else if (part == "both") {
        both();
    } else {
        composite();
    }
}

print_part();
//inverted_vents();