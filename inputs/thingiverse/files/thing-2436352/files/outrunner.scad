$fa=0.5;
$fn=180;

driveshaft_h=50;
driveshaft_od=4;
bell_od=40;
bell_h=15;
bell_wall=2.5;
bell_ceil=2;
driveshaft_behind_bell=18;

axle_holder_h=6;
static_shaft_od=8;

mount_od=40;
mount_height=12;
mount_thick=2;
mount_wall=3;

mount_type=0; //0 for round plate, 1 for stick mount

fullmotor(
    driveshaft_h=driveshaft_h,
    driveshaft_od=driveshaft_od,
    bell_od=bell_od,
    bell_h=bell_h,
    bell_wall=bell_wall,
    bell_ceil=bell_ceil,
    driveshaft_behind_bell=driveshaft_behind_bell,
    axle_holder_h=axle_holder_h,
    
    static_shaft_od=static_shaft_od,
    
    mount_od=mount_od,
    mount_height=mount_height,
    mount_thick=mount_thick,
    mount_wall=mount_wall,
    mount_type=mount_type
);

module fullmotor(
    driveshaft_h=50,//total length of driveshaft
    driveshaft_od=4,
    bell_od=40,
    bell_h=15,
    bell_wall=1,//wall thickness of bell
    bell_ceil=1,//thickness of the bell top
    driveshaft_behind_bell=10,//protrusion behind bell
    axle_holder_h=6,
    
    static_shaft_od=6,
    
    mount_od=40,
    mount_height=8,
    mount_thick=1,
    mount_wall=2,
    mount_type=0
){
    color("red")
        bell(driveshaft_h=driveshaft_h,
             driveshaft_od=driveshaft_od,
             bell_od=bell_od,
             bell_h=bell_h,
             bell_wall=bell_wall,
             bell_ceil=bell_ceil,
             driveshaft_behind_bell=driveshaft_behind_bell,
             axle_holder_h=axle_holder_h
            );
    color("yellow")
        stator(
                bell_od=bell_od,
                bell_wall=bell_wall,
                bell_ceil=bell_ceil,
                bell_h=bell_h,
                driveshaft_od=driveshaft_od,
                driveshaft_behind_bell=driveshaft_behind_bell,
                static_shaft_od=static_shaft_od
            );
    color("blue"){
        if(mount_type==0){
            plateMount(
                    driveshaft_behind_bell=driveshaft_behind_bell,
                    mount_height=mount_height,
                    mount_od=mount_od,
                    mount_wall=mount_wall,
                    mount_thick=mount_thick,
                    static_shaft_od=static_shaft_od);
        }
        if(mount_type==1){
            stickMount(driveshaft_behind_bell=driveshaft_behind_bell,
                    mount_height=mount_height,
                    mount_od=mount_od,
                    mount_wall=mount_wall,
                    mount_thick=mount_thick,
                    static_shaft_od=static_shaft_od);
        }
    }
}

module bell(driveshaft_h, driveshaft_od, bell_od, bell_h, bell_ceil, driveshaft_behind_bell,axle_holder_h){
    translate([0,0,driveshaft_behind_bell])
        union(){
            intersection(){
                difference() {
                    cylinder(h=bell_h, r=bell_od/2);
                       translate([0,0,-1])
                            cylinder(h=bell_h, r=bell_od/2-bell_wall);
                    for (x=[0:5])
                        rotate([0,0,360/6*x])
                            translate([bell_od/3,0,-5])
                                cylinder(h=30,r=bell_od/10);
                }
                translate([0,0,-100+bell_h+bell_od/2-(bell_wall+bell_ceil)/3])
                    cylinder(h=100,r1=100,r2=0);
                
            }
            translate([0,0,-driveshaft_behind_bell]){
                cylinder(h=driveshaft_h, r=driveshaft_od/2); //driveshaft
            }
            translate([0,0,bell_h])
                difference(){
                    cylinder(h=axle_holder_h,r=10/2);
                        translate([0,0,axle_holder_h/2])
                            rotate([90,0,0])
                                cylinder(h=30,r=2.5/2);
                }
        }
}
module stator(bell_od, bell_wall, bell_ceil, bell_h, driveshaft_od, driveshaft_behind_bell, static_shaft_od){
    
    translate([0,0,driveshaft_behind_bell])
    for(x=[0:7])
        rotate([0,0,360/8*x])
            translate([-1,driveshaft_od/2,0])
                cube([2,-driveshaft_od/2+bell_od/2-bell_wall-1,bell_h-bell_ceil-1]);
    difference(){
        hstatic=driveshaft_behind_bell+bell_h-bell_ceil;
        cylinder(h=hstatic, r=static_shaft_od/2);
        translate([0,0,-1])
            cylinder(h=hstatic+2,r=driveshaft_od/2);
    }
}
 
module plateMount(driveshaft_behind_bell,mount_height,mount_od,mount_wall,mount_thick,static_shaft_od){
        difference(){
            cylinder(h=mount_height,r=mount_od/2);
            difference(){
                translate([0,0,mount_thick])
                    cylinder(h=mount_height,r=mount_od/2+1);
                cylinder(h=mount_height,r=static_shaft_od/2+mount_wall);
            }
            translate([0,0,-1])
                cylinder(h=100, r=static_shaft_od/2); //inner hole
            translate([-15,0,5]) 
                rotate([0,90,0])
                    cylinder(h=30,r=1.25); //set screw hole
            for(x=[0:2])
                rotate([0,0,360/3*x])
                    translate([-10,0,-2])
                        cylinder(h=20,r=1.5);//attachment screw hole
        }
        
            
        
}

module stickMount(mount_height,mount_od,static_shaft_od){
    difference(){
        cylinder(h=mount_height,r=mount_od/2);
        translate([6,-4,-1])
            cube([8,8,mount_height+2]);
    }
}