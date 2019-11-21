// wedge
// angle of wedge

// to make wedge as bevel guide, angle = 90 - bevel-angle

angle=31.72;
// length of sloping side in mm
slope =30;
// length of wedge in mm
length = 30;
//depth of engraved text
text_depth = 2;

function perimeter_to_polygon(peri,pos=[0,0],dir=0,i=0) =
    i == len(peri)
      ? [pos]
      : let(side = peri[i])
        let (distance = side[0])
        let (newpos = pos + distance* [cos(dir), sin(dir)])
        let (angle = side[1])
        let (newdir = dir + (180 - angle))
        concat([pos],perimeter_to_polygon(peri,newpos,newdir,i+1)) 
     ; 

function perimeter(angle,slope) =
   [[slope*cos(angle),angle],[slope ,90-angle], [slope*sin(angle),90]];


polygon = perimeter_to_polygon(perimeter(angle,slope));

difference() {
     rotate([90,0,0]) 
           linear_extrude(height=length)
           polygon(polygon);
     translate([text_depth-0.10,-length/5,slope*sin(angle)/3])
         rotate([90,0,0])
            rotate([0,-90,0])
                linear_extrude(height=text_depth) 
                     text(str(angle),size=slope*sin(angle)*0.4,font="Liberation Sans:style=Bold");
  }