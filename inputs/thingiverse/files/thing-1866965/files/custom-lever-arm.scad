

length_HandleArm=150;//[20:250]
length_MountArm=100;//[20:250]
position_Arm=50;//[0:1]
angle_MountArm=20;//[5:90]
maxarm=(length_HandleArm-20);
HandleHole=3;
MountHole=3;
position_Arm1=(position_Arm/100);


    color("Blue")
difference(){
cube([10,length_HandleArm,10],0,0,0);
    translate([5,0,0])
    cylinder(h=40,r=HandleHole,center=true);
    }
translate([5,length_HandleArm,0])
    color("Blue")
    cylinder(h=10,r=5);

translate([5,0,0])
color("OrangeRed")
    difference(){
        cylinder(h=10,r=5);
        cylinder(h=40,r=HandleHole,center=true);  
    }
translate([0,maxarm*position_Arm1,0])
rotate(a=[0,0,angle_MountArm])
    color("OrangeRed")
    difference(){
        union(){
            cube([10,length_MountArm,10],0,0,0);
            translate([5,length_MountArm,0])
            cylinder(h=10,r=5,center=false);
            
        }
        translate([5,length_MountArm,0])
        cylinder(h=40,r=MountHole,center=true);
    }
    
    
    
