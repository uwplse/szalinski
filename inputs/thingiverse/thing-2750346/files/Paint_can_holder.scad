// The number cell to A side
Grid_A = 4;

// The number cell to B side
Grid_B = 4;

// The wall heigth
Grid_heigth = 15;

// The size of the paint bottle
Bottle_size = 25.4;

// Brush holder
Brush = 0; // [1:Yes, 0:No]

// Brush holder wall heigth
Brush_wall =60;


cube([Grid_A*(1+Bottle_size),Grid_B*(Bottle_size+1),1]);
for(i=[0:1:Grid_A]){
    translate([(Bottle_size+1)*i,0,0])cube([1,Grid_B*(Bottle_size+1)+1,Grid_heigth]);
}
for(i=[0:1:Grid_B]){
    translate([0,(Bottle_size+1)*i,0])cube([Grid_A*(Bottle_size+1)+1,1,Grid_heigth]);
}
if(Brush){
    for(i=[0:1:Grid_A]){
        translate([(Bottle_size+1)*i,-(Bottle_size+1),0])cube([1,(Bottle_size+1)+1,Brush_wall]);
    }
    for(i=[0:1:1]){
        translate([0,-(Bottle_size+1)*i,0])cube([Grid_A*(Bottle_size+1)+1,1,Brush_wall]);
    }
    translate([0,-(Bottle_size+1),0])cube([Grid_A*(1+Bottle_size),(Bottle_size+1),1]);
}