use <write/Write.scad>
// preview[view: south, tilt:top diagonal]

Font = "write/orbitron.dxf";//["write/Letters.dxf":Basic,"write/orbitron.dxf":Futuristic,"write/BlackRose.dxf":Fancy]
favorite_donut="Boston Cream";
favorite_coffee_place="Starbucks";
height_of_donut_letters=10;//[5:12]
height_of_coffee_place_letters=8;//[5:12]
thermos();

module thermos(){


rad1=70.3/2;
rad2=76.88/2;
writecylinder(favorite_donut,[0,0,0],rad1+4,20,rotate=0, h=height_of_donut_letters, font=Font);
writecylinder(favorite_coffee_place,[0,0,-15],rad1+3,20,rotate=0, h=height_of_coffee_place_letters, font=Font);
difference(){
cylinder(r1=rad1+1.5,r2=rad2+1.5,h=40,$fn=128, center=true);
translate([0,0,0])
cylinder(r1=rad1,r2=rad2,h=41,$fn=128, center=true);
}
}