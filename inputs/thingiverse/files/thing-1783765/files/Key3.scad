//  - The number of sides.
hole_sides = 6; // [3:12]

//  - For an even number of sides, this is the perpendicular distance between two opposite, parallel sides. For an odd number of sides, this is the perpendicular distance from the middle of one side to the opposite corner.
hole_diameter = 5.7;

//  - The depth of the hole.
hole_depth = 8; // 4+

//  - Do you need a hole in the handle?
string_hole = 1;//[0:No, 1:Yes]

//  - Minimal outer diameter - use this to make the `trunk' of the key thicker.
min_outer_diameter = 0;

//  - Do you need to add a foot/brim to increase adhesion during printing?
add_foot = 0;//[0:No, 1:Yes]

//  - Which handle style? Numbers 2 & 3 don't look right in Customiser, but render fine!
handle = 1;//[1,2,3]


hole_height = hole_depth + hole_diameter;
w = hole_diameter/2+2;
h = hole_height + 1;

difference()
{
  union()
  {
    cyl_rad_min = diam2rad(hole_diameter, hole_sides) + 2;
    cyl_rad = max(cyl_rad_min, min_outer_diameter/2);
    
   // cyl_top = handle == 2 ? max(1, hole_depth / 6) : 0;
    cyl_top = handle == 1 ? 0 : (handle == 2 ? max(1, hole_depth / 6) : max(0.5, hole_depth / 8));
    cylinder(hole_height + 1, cyl_rad, cyl_rad+cyl_top, $fn = 96);
    
    if(add_foot)
      feet(cyl_rad);
    
    translate([0, 0, hole_height+1])
    if(handle == 1)
      cylinder(4, cyl_rad+cyl_top, 0, $fn = 96);
    else
      cylinder(2, cyl_rad+cyl_top, 0, $fn = 96);
    
    handle_thickness = min(10, max(4, hole_diameter/4+2));

    if(handle == 1)
      handle1(handle_thickness, cyl_rad);
    else if(handle == 2)
      handle2(handle_thickness, cyl_rad);
    else if(handle == 3)
      handle3(handle_thickness, cyl_rad);
  }

  if(string_hole)
    translate([0, 0, handle!=3?1.4*h+1.5:1.2*h+1.0])
      rotate([90])
        difference()
        {
          cylinder(11, 2.6, 2.6, true, $fn = 96);
          translate([0, 2.4, 0])
            cube([5.2, 0.4, 12], true);
        }

  nPrism(hole_sides, hole_diameter, hole_depth);
}


module nPrism(sides, diam, ln)
{
  l  = diam2rad(diam, sides);
  l2 = diam2rad(diam + 2, sides);
  
  linear_extrude(height = ln)
    polygon(points=[for(i=[0:(360/sides):360]) l*[cos(i), sin(i)]]);

  translate([0,0,ln])
    linear_extrude(height = diam, scale = 0)
      polygon(points=[for(i=[0:(360/sides):360]) l*[cos(i), sin(i)]]);

  translate([0,0,-1])
    linear_extrude(height = diam+2.5, scale = 0)
      polygon(points=[for(i=[0:(360/sides):360]) l2*[cos(i), sin(i)]]);
}

module feet(rad)
{
  difference()
  {
    union()
    {
      difference()
      {
        cylinder(0.4, rad+6, rad+6, $fn = 48);
        cylinder(1, rad+1, rad+1, $fn = 48, true);
      }
      
      cnt=(3.141592*rad)/4;
      for(i = [0:(180/cnt):180])
        rotate([0, 0, i])
          translate([-rad-2, -0.5, 0])
            cube([2*rad+4, 1, 0.4]);
    }
  
    cylinder(1, rad-0.1, rad-0.1, $fn = 48, true);
  }
}

module handle1(thickness, cyl_rad)
{
  rotate([90])
    difference()
    {
      linear_extrude(height = thickness, center=true)
        minkowski()
        {
          polygon(points = [[0, hole_depth], [w*1.6, 1.2*h-0.5], [w*1.7, 1.4*h+1.5],[cyl_rad, 1.4*h+2.0], [-cyl_rad, 1.4*h+2.0], [-w*1.7, 1.4*h+1.5], [-w*1.6, 1.2*h-0.5], [0, hole_depth]]);
          circle(min(5, hole_depth), $fn=96);
        }

      translate([0, 0, thickness/2])
      linear_extrude(height = 1.2, center=true)
        minkowski()
        {
          polygon(points = [[0, hole_depth], [w*1.6, 1.2*h-0.5], [w*1.7, 1.4*h+1.5],[0, 1.4*h+1.8], [-w*1.7, 1.4*h+1.5], [-w*1.6, 1.2*h-0.5], [0, hole_depth]]);
          circle(min(5, hole_depth)-2, $fn=96);
        }
        
      translate([0, 0, -thickness/2])
      linear_extrude(height = 1.2, center=true)
        minkowski()
        {
          polygon(points = [[0, hole_depth], [w*1.6, 1.2*h-0.5], [w*1.7, 1.4*h+1.5],[0, 1.4*h+1.8], [-w*1.7, 1.4*h+1.5], [-w*1.6, 1.2*h-0.5], [0, hole_depth]]);
          circle(min(5, hole_depth)-2, $fn=96);
        }
     }
 }


module handle2(thickness, cyl_rad)
{
  rotate([90])
  intersection()
  {
    rotate_extrude(angle=190, $fn = 96)
      rotate([0,0,90])
        difference()
        {
          union()
          {
           polygon(points = [[-thickness/2+1, 0], [thickness/2-1, 0], 
                             [ thickness/2, 1.4*h+1.8+4],
                             [-thickness/2, 1.4*h+1.8+4]]);
           translate([0, 1.4*h+1.8+4])
             circle(thickness/2+0.0, $fn = 96*2);
          }
        }
        
    linear_extrude(height = thickness+2, center=true)
    {
      polygon(points = [[-cyl_rad+0.5, 0],[cyl_rad-0.5, 0],
                     [ 1.5*h+1, 2.8*h+4],
                     [-1.5*h-1, 2.8*h+4]]);
    }
  }
}
 

module handle3(thickness, cyl_rad)
{
  wid = w*1.7*2+min(5, hole_depth) - thickness/2;
  rd = wid*3;
  ht = 1.4*h+7.0;
  r = (w*1.7*2 + min(5, hole_depth)) / 2;
  l = r*r/ht;
  
  difference()
  {
    translate([0, 0, 1.2*h+1-l])
    {
      rotate([180])
        linear_extrude(height = ht-l, scale = 0)
          projection(cut = true)
            translate([0, 0, l])
              rotate([90])
                shape3D(thickness, cyl_rad);
                  
      difference()
      {
        translate([0, 0, l])
          rotate([90])
            shape3D(thickness, cyl_rad);
        
        translate([-(wid+thickness+1)/2, -(thickness+1)/2, -wid])
          cube([wid+thickness+1, thickness+1, wid]);
      }
    }
    translate([0, 0, -ht/2])
      cube([wid, cyl_rad*2, ht], true);
  }
}

module shape3D(thickness, cyl_rad)
{
  wid = w*1.7*2+min(5, hole_depth) - thickness/2;
  rd = wid*3;
  
  rotate_extrude($fn = 96*2)
    difference()
    {
      union()
      {
        square([wid, thickness], true);
        //translate([wid/2, 0])
          //circle(thickness/2, $fn = 96);
        translate([-wid/2, 0])
          circle(thickness/2, $fn = 96);
      }
        
      translate([0, sqrt(rd*rd - wid*wid/4)+thickness/2])
        circle(rd, $fs = 0.5, $fa = 0.1);
      translate([0, -sqrt(rd*rd - wid*wid/4)-thickness/2])
        circle(rd, $fs = 0.5, $fa = 0.1);

      translate([0, -thickness/2])
        square([wid, thickness]);
    }
}

function diam2rad(diam, sides) = isOdd(sides) ? diam/(1 + cos(180/sides)) : diam/ (cos(180/sides) * 2);
function isOdd(t) = (t-(floor(t/2)*2));