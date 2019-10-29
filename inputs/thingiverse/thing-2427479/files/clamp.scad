//Clamp inner diameter
clamp_id = 20; //[1:200]

//Clamp height
clamp_h = 20; //[1:200]

//Wall Thickness
wall = 3; //[1:20]

//Diameter of screw holes
screw_d = 3; //[1:15]

//Count of screw holes to be places alongside each side
screws = 2; //[0:20]

//Diameter of nut trap (set to 0 to disable)
nut_d = 6; //[0:20]

translate([-(clamp_h+10),0,0])
rotate([0,90,0])
difference() {
clamp();
translate([0,-(clamp_id+wall*16)/2,-0.01])
cube([clamp_id+wall,clamp_id+wall*16,clamp_h*2]);
}

translate([clamp_h+10,0,0])
rotate([0,-90,0])
intersection() {
clamp();
translate([0,-(clamp_id+wall*16)/2,0])
cube([clamp_id+wall,clamp_id+wall*16,clamp_h*2]);
}

module clamp() {

    difference() {
        cylinder(d=clamp_id+wall*2,h=clamp_h,$fn=50);
        translate([0,0,-1])
        cylinder(d=clamp_id,h=clamp_h+2,$fn=50);
    }
    
    translate([0,clamp_id/2+screw_d+wall,clamp_h/2])
    plate();
    
    translate([0,-(clamp_id/2+screw_d+wall),clamp_h/2])
    plate();

}

module plate()
{
    difference() {
        cube([wall*2,screw_d+wall*2,clamp_h], center=true);
        
        if(screws > 1)
        {
            h = (clamp_h - wall*2) / (screws - 1);
            
            for(i=[0:screws-1])
            {
                translate([0,0,clamp_h/2-wall-(h*i)])
                screwhole();
            }
        }
        else if(screws == 1)
        {
            screwhole();
        }
    }
}

module screwhole()
{
    rotate([0,90,0])
    union() {
        cylinder(d=screw_d, h=wall*2+0.5, $fn=50, center=true);
        translate([0,0,-wall*0.75])
        cylinder(d=nut_d, h=wall/2+0.05, $fn=6, center=true);
    }
}