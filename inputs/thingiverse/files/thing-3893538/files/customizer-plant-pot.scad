//Haley Edie
//Customizer Project
//10-1-19

//cubes width and height
h = 50;

$fn = 100;

//bottom water void 
difference(){
union(){
    cube(h,center=true);
    difference(){
    translate([0,0,h/2]) cube([h-4,h-4,h-(h-10)],center=true);
    translate([0,0,h/2]) cube([h-7,h-7,h-10],center=true);  
    }
}
    
translate([0,0,h-(h-10)]) cube(h-10,center=true);

}


//top plant pot

translate([h*2,0,-h*2]) //move to build plate
difference(){
difference(){
    difference(){
    translate([0,0,h*2]) cube(h,center=true);
        
    difference(){
    translate([0,0,(h*2)-25]) cube([h-3,h-3,h-(h-10)],center=true);
    translate([0,0,(h*2)-25]) cube([h-7,h-7,h-10],center=true);  
    }
    
    }
    translate([0,0,(h*2)+20]) cube([h-3,h-3,h+20], center=true);
}

for (i = [0:5]) {
    echo(360*i/6, sin(360*i/6)*80, cos(360*i/6)*80);
    translate([sin(360*i/6)*10, cos(360*i/6)*10, h+10 ])
    cylinder(h = h-10, r = h-(h-1.5));
}
}