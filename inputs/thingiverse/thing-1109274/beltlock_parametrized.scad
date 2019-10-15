//CUSTOMIZER VARIABLES

//Inner size X in mm
inner_x=2.6;
//Inner size Y in mm
inner_y=6.5;
//Height Z in mm
height=15;

//CUSTOMIZER VARIABLES END

module BeltLock(x_in, y_in, h,  $fn=100) {
    wall = 1.2;
    difference(){
        cube([x_in+wall*2,y_in+wall*2,h]);
        translate([wall, wall,0])cube([x_in,y_in,h]);
        translate([(x_in+wall*2)/2,(y_in+wall*2)/2,h-wall])
            hull(){cube([x_in,y_in,0.01], center=true);
                translate([0,0,wall*2])cube([x_in+wall*2,y_in+wall*2,0.01],center=true);}
    
        }
}

BeltLock(inner_x, inner_y, height);
   
/* source   
translate([10,0,0])
difference(){
    cube([2.8+2.4,6.5+2.4,15]);
    translate([1.2,1.2,0])cube([2.8,6.5,15]);
    #translate([2.6,8.9/2,15-1.2])
  hull(){cube([2.8,6.5,0.01],center=true);
   translate([0,0,2.4])cube([2.8+2.4,6.5+2.4,0.01],center=true);}
}
*/
