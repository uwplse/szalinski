// a high number is more round, low number is more lo-poly
$fn=50;

// height of candle in mm
height= 100;

// diameter of candle in mm
diameter= 50;

// diameter of wick in mm
wick = 2;

// diameter of pins that help align the mold
pin_size  = 3;

// the pins are slightly conical, smaller at the end.   this amount is how much smaller.   This helps the pins to fit into the holes. 
pin_epsilon = 0.1;

// There can be a 45 degree bevel at the top of the candle. 
bevel = 1;

module  section()
{
    difference(){
        union(){
            union(){ 
                cylinder(r=diameter/2, h=height-bevel);// main cylinder of candle
                translate([0,0,height-bevel])
                    cylinder(r1=diameter/2, r2 = diameter/2 - bevel, h=bevel);
                translate([0,0,height-5])cylinder(r=wick/2,h=10);// wick
            }
            union(){ //we only want 1/3rd, so block the rest out
                translate([0,-diameter,0])cube([diameter,diameter,height+10]);
                translate([-diameter,-diameter,0])cube([diameter,diameter,height+10]);
                rotate([0,0,360/3])cube([diameter,diameter,height+10]);    
            }
          
            translate([diameter/2 + pin_size*3/2,pin_size,height/3])// pins
                rotate([90,0,0])cylinder(r=pin_size, h=pin_size);
            translate([diameter/2 + pin_size*3/2,pin_size,(height*2)/3])
                rotate([90,0,0])cylinder(r=pin_size, h=pin_size);
        }
    union(){   
        rotate([0,0,360/3])// holes the pins fit into
            translate([diameter/2 + pin_size*3/2,pin_size,height/3])
                rotate([90,0,0])cylinder(r2=pin_size,r1=pin_size-pin_epsilon, h=pin_size);
        rotate([0,0,360/3])
            translate([diameter/2 + pin_size*3/2,pin_size,(height*2)/3])
                rotate([90,0,0])cylinder(r2=pin_size,r1=pin_size-pin_epsilon, h=pin_size);    
    }
  }  
}

rotate([-60,0,0])rotate([0,90,0])difference(){
    rotate([0,0,360/6])translate([0,-diameter*0.6,0])cube([diameter*.6,diameter*1.2,   height+5]);
    section();
}
