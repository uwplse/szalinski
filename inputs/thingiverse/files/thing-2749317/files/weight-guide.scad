
wall=10;
w=44.5;
h=31.75;
axelDistFromRear=24.5;
weigthDia=9.5;

difference(){
    difference(){
        translate([-wall,0,0])
            cube([2*wall+w,axelDistFromRear+2*weigthDia,h+wall]);
        //back hole
        translate([w/2,axelDistFromRear/2,h])
            cylinder(d=9.5,h=wall);
        
        //front holes
        translate([w/2,axelDistFromRear+weigthDia,h]){
            cylinder(d=9.5,h=wall);
            translate([-w/3,0,0]) cylinder(d=9.5,h=wall);
            translate([w/3,0,0]) cylinder(d=9.5,h=wall);
        }
        
        //axel guide
        translate([-wall,axelDistFromRear-.7,h+wall])
            rotate([0,90,0]) #cube([wall,2,w+2*wall]);
    }

    cube([w,180,h]);
}