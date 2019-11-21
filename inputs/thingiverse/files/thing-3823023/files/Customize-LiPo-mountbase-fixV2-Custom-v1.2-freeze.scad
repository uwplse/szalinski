battery_length=70;
battery_height=6;
battery_width=50;
// high is not be tested it can be it will not fit in!
wall_height=2; // [3:low,2:medium,1.5:!high!]
thickness=2; // [1:3]
hole= 3; // [0:8]
sunk_screws=0; // [0:NO, 1:YES]
light=1; // [0:NO, 1:YES]
band_hole=1; // [0:NO, 1:YES]
thick_edge=0; // [0:NO, 1:YES]
//If you don't need it set to 0
mount_basis_length= 90;
//If you don't need it set to 0
mount_basis_width= 60;
mount_basis_thickness= 2; // [1:3]
//mount_basis_length need to be higher than
mb_hole_distance_length= 80;
//mount_basis_width need to be higher than
mb_hole_distance_width= 50;


module Akku(){
cube([battery_length,battery_width,battery_height],center=true);
}


module Case(L,B,H)
{
    difference(){
        cube([L,B,H],center=true);
        Akku();


        if(battery_length > 100)
        {
        translate([25,0,thickness+battery_height/wall_height]){
        cube([L,B+0.5,H],center=true);
        }
        } else {
        translate([battery_length/4,0,thickness+battery_height/wall_height]){
        cube([L,B+0.5,H],center=true);
        }
        }

        if(light==1)
        {
        translate([-L/2,0,0])
        {
        cube([L,battery_width-thickness*4,battery_height-thickness*4],center=true);
        }
        }



        translate([L/2,battery_width/2-thickness*12.5,-1])
        {
        cube([L,thickness*8,battery_height-thickness*1.5],center=true);
        }
//        translate([L/2,-battery_width/2+thickness*1.5,0])
//        {
//        cube([L,thickness*3,battery_height-thickness*2],center=true);
//        }



        if(thick_edge==1)
        {
        if(battery_length/5 > 20)
        {
        translate([battery_length,battery_width/2,0])
        {
        cube([battery_length+20,thickness*3,battery_height-thickness*2],center=true);
        }
        translate([battery_length,-battery_width/2,0])
        {
        cube([battery_length+20,thickness*3,battery_height-thickness*2],center=true);
        }
        } else{
        translate([battery_length,battery_width/2,0])
        {
        cube([battery_length+battery_length/5,thickness*3,battery_height-thickness*2],center=true);
        }
        translate([battery_length,-battery_width/2,0])
        {
        cube([battery_length+battery_length/5,thickness*3,battery_height-thickness*2],center=true);
        }
        }
        }



        if(band_hole==1)
        {
        translate([battery_length/5,0,-battery_height/2+1.5])
        {
        if(battery_length > 60)
        {
        cube([20,battery_width+thickness*2+1,3],center=true);
        } else {
        cube([battery_length/3,battery_width+thickness*2+1,3],center=true);
        }
        }
        }




        if(light==1&&mb_hole_distance_length>battery_length+thickness*2||light==1&&mb_hole_distance_width>battery_width+thickness*2)
        {
    translate([battery_length/4,battery_width/4,-battery_height/2-0.1])
    {
    cube([battery_length/2.5,battery_width/3,thickness*2],center=true);
    }
    translate([-battery_length/4,-battery_width/4,-battery_height/2-0.1])
    {
    cube([battery_length/2.5,battery_width/3,thickness*2],center=true);
    }
    translate([battery_length/4,-battery_width/4,-battery_height/2-0.1])
    {
    cube([battery_length/2.5,battery_width/3,thickness*2],center=true);
    }
    translate([-battery_length/4,battery_width/4,-battery_height/2-0.1])
    {
    cube([battery_length/2.5,battery_width/3,thickness*2],center=true);
    }
    }else{
    translate([mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }
    translate([mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }
    if(sunk_screws==1)
    {
    translate([mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    translate([mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    }    
    }   
    }
}






difference(){
    translate([0,0,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cube([mount_basis_length,mount_basis_width,mount_basis_thickness],center=true);
    }
    translate([0,0,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cube([battery_length+thickness*2,battery_width+thickness*2,battery_height+thickness*2],center=true);
    }



    translate([mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }
    translate([mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness/2])
    {
    cylinder(d=hole,h=mount_basis_thickness*2,$fn=20,center=true);
    }





    if(sunk_screws==1)
    {
    translate([mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    translate([mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    translate([-mb_hole_distance_length/2,-mb_hole_distance_width/2,(-battery_height-thickness*2)/2+mount_basis_thickness-hole/4])
    {
    cylinder(d1=hole,d2=hole*2,h=hole/2,$fn=20,center=true);
    }
    }
}




Case(battery_length+thickness*2,battery_width+thickness*2,battery_height+thickness*2); 



