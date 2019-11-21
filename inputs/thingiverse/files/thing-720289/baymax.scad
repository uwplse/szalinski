//Move left foot, angle
Left_foot_X=9;
Left_foot_Y=0;
Left_foot_Z=9;
//Move right foot, angle
Right_foot_X=0;
Right_foot_Y=9;
Right_foot_Z=9;
//Move left arm, angle
Left_arm_X=0;
Left_arm_Y=0;
Left_arm_Z=0;
//Move left forearm, angle
Left_forearm_X=-40;
Left_forearm_Y=0;
Left_forearm_Z=0;
//Move left arm, distance
Left_arm_X_move=0;
Left_arm_Y_move=4;
Left_arm_Z_move=0;
//Move right arm, angle
Right_arm_X=0;
Right_arm_Y=0;
Right_arm_Z=0;
//Move right forearm, angle
Right_forearm_X=-30;
Right_forearm_Y=0;
Right_forearm_Z=0;
//Move right arm, distance
Right_arm_X_move=0;
Right_arm_Y_move=4;
Right_arm_Z_move=0;
//Move head, angle
Head_X=-5;
Head_Y=20;
Head_Z=-5;
//Resolution, less than 100 will be OK
Resolution=50;
$fn=Resolution;
//Make baymax stand up
rotate([90,0,0])union(){
//The body
union(){resize(newsize=[30,40,25])sphere(10);
translate([0,-10])rotate([-90,0,0])resize(newsize=[29.5,25,10])cylinder(h=8,r1=13,r2=13,center=false);
translate([0,-10])resize(newsize=[32,35,26])sphere(10);
translate([6,8,10])rotate([-12,20,0])cylinder(h=1,r1=2,r2=2,center=false);}
//The head
rotate([Head_X,Head_Y,Head_Z])union(){translate([0,22])resize([15,12,15])sphere(10);
translate([-4,22.5,6])rotate([0,-30,0])cylinder(h=1,r1=1.5,r2=1.5,$fn=15);
translate([4,22.5,6])rotate([0,30,0])cylinder(h=1,r1=1.5,r2=1.5,$fn=15);
translate([0,22.5,5])rotate([90,90,0])resize([6,10,1])cylinder(h=1,r=5,$fn=20);}
//The feet
rotate([Right_foot_Y,Right_foot_Z,Right_foot_X])translate([-7,-23,0])resize([13,20,15])sphere(10);
rotate([Left_foot_Y,Left_foot_Z,Left_foot_X])translate([7,-23,0])resize([13,20,15])sphere(10);
//Right arm
translate([Right_arm_X_move,Right_arm_Y_move,Right_arm_Z_move])rotate([Right_arm_X,Right_arm_Y,Right_arm_Z])union(){translate([-12,5])rotate([0,0,-35])resize(newsize=[8,20,10])sphere(10);
rotate([Right_forearm_X,Right_forearm_Y,Right_forearm_Z])union(){translate([-20,-7,0])rotate([0,0,-30])resize(newsize=[7,20,11])sphere(10);
translate([-24,-16,0])resize(newsize=[2,6,2])sphere(5);
translate([-23,-14,-2.5])resize(newsize=[2,6,2])sphere(5);
translate([-23,-14,2.5])resize(newsize=[2,6,2])sphere(5);
translate([-20,-12,3])resize(newsize=[2,6,2])sphere(5);}}
//Left arm
translate([Left_arm_X_move,Left_arm_Y_move,Left_arm_Z_move])rotate([Left_arm_X,Left_arm_Y,Left_arm_Z])union(){translate([12,5])rotate([0,0,35])resize(newsize=[8,20,10])sphere(10);
rotate([Left_forearm_X,Left_forearm_Y,Left_forearm_Z])union(){translate([20,-7,0])rotate([0,0,30])resize(newsize=[7,20,11])sphere(10);
translate([24,-16,0])resize(newsize=[2,6,2])sphere(5);
translate([23,-14,-2.5])resize(newsize=[2,6,2])sphere(5);
translate([23,-14,2.5])resize(newsize=[2,6,2])sphere(5);
translate([20,-12,3])resize(newsize=[2,6,2])sphere(5);}}
}









