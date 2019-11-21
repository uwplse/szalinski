scope_dia = 50;
insert_length = 40;
pipe_outside_diameter = 43;
pipe_inside_diameter = 40;

module scope_adapter(){
difference(){
union(){

//create main scope eye piece tube
cylinder(r=(scope_dia + 4)/2,h=insert_length,$fn=50);

//create taper between eye piece and spigot
translate([0,0,insert_length]) cylinder(r1=(scope_dia+4)/2,r2=pipe_inside_diameter/2,h=10);

//create spigot for gluing inside 40mm solvent weld waste pipe 
translate([0,0,insert_length+10]) cylinder(r=pipe_inside_diameter/2,h=20,$fn=60);
}

//create socket for scope eye piece
translate([0,0,-2]) cylinder(r=(scope_dia)/2,h=insert_length+2,$fn=40);

//hollow out taper section
translate([0,0,insert_length-3]) cylinder(r1=(scope_dia)/2,r2=(pipe_outside_diameter-4)/2,h=14);

//create a couple of cut out for a bit of give
translate([scope_dia/2-1,-2,-1]) cube([4,4,insert_length/2]);
translate([-scope_dia/2-3,-2,-1]) cube([4,4,insert_length/2]);

//create hole through top spigot
translate([0,0,insert_length+10]) cylinder(r=(pipe_inside_diameter-4)/2,h=25);
}
}

//generate model and flip upside down for easier printing
translate([0,0,insert_length+30]) rotate([180,0,0]) scope_adapter();
