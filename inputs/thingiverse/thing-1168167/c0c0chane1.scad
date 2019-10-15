//+-------------------------------------------------+
//|  OPENSCAD double pipe clamp - c0c0chane1 clamp  |
//|        2015 gaziel@gmail.com                    |
//+- -----------------------------------------------+   
   
// Diameter for the first Pipe
dp1= 30;
// Diameter for the first Pipe
dp2= 10;
//Thinkness=5;
ep=3;

//hole for colson, rilsan or hose clamp
dh=1;//hole diameter for the hose clamp, "0" for no-hole.
$fn=50;

orientation=0;//Orientation in degree (zero for straight)

translate([-(dp2+ep)/2,0,0])rotate([0,0,180])ring(dp2,0);
translate([(dp1+ep)/2,0,0])ring(dp1,orientation);

module ring(dp,or){;
    difference(){
        hull(){
            rotate([or,0,0])cylinder(d=dp+ep,h=ep, center=true);
            translate([-(dp+ep)/2,0,0])rotate([90,0,0])cylinder(d=ep,h=2*ep, center=true);
        }
        rotate([or,0,0]){
        union(){
            cylinder(d=dp,h=dp, center=true);
            rotate([0,0,225]) translate([-dp,0,-dp*3])cube([dp,dp,6*dp]);
            translate([-(dp+ep)/2,0,0])rotate([90,0,0])cylinder(d=dh,h=3*ep, center=true);    
            }
        }
        translate([-(dp+ep)/2,0,0])rotate([90,0,0])cylinder(d=dh,h=dp*ep, center=true);   
    }
}
