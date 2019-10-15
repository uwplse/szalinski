width = 54;
height = 50;
wall_thickness = 2;
num_sec = 9;

num_middle=num_sec-1;


module start(){
    difference(){
        translate([0,-10,0])cube([width, 20, height], center=true);
        translate([0,wall_thickness-10, wall_thickness]) 
        cube([width-2*  wall_thickness, 20, height], center=true);
    }
}

module end(){
translate([0,wall_thickness/2, 0])cube([width, wall_thickness, height], center=true);
}

module front_back(){
union(){
start();
translate([0, (num_sec-1)*20, 0])end();
}
}

module middle(){
difference(){
translate([0,10,0])cube([width, 20, height], center=true);
translate([0,10,wall_thickness])cube([width-2*wall_thickness, 20, height], center=true);
translate([0, 2, height/2-1.5])cube([width, 4, 3], center=true);
translate([(width/2)-(((width/2)-wall_thickness-8)/2)-wall_thickness, 1.5, -height/2+wall_thickness/2])cube([(width/2)-wall_thickness-8, 3, wall_thickness], center=true);
translate([-((width/2)-(((width/2)-wall_thickness-8)/2)-wall_thickness), 1.5, -height/2+wall_thickness/2])cube([(width/2)-wall_thickness-8, 3, wall_thickness], center=true);
    }
}

module make(){
    union(){
        for(i = [0:num_middle-1]) {
            translate([0,i*20,0])middle();
        }
        front_back();
    }
}

make();