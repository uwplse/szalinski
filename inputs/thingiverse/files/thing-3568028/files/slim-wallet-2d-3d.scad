wallet_3d=true; //set to false for 2d view but cannot use the online Customizer
logo=false; //if you want a .dxf logo to be added, set to true, but you cannot use the online Customizer and it doesn't affect the 2d view
card_width=86.1;
card_length=54.5;
card_radius=3.5;
wall_thickness=0.125*25.4;
material_thickness=0.3*25.4;//used for 3d view only
card_thickness=material_thickness-0.125*25.4;//used for 3d view only
band_inset_width=wall_thickness;//taken from both the left and right sides along the card width
band_inset_length=10;//how wide to make the band cutout along the length of the card
card_inset_width=20;//amount of inset along the top
card_inset_length=card_width/8;//amount of inset along the top
if (wallet_3d==true){$fn=30;}


if (wallet_3d==true){
slim_wallet_3d();
}
if (wallet_3d==false){
slim_wallet_2d();
}

module slim_wallet_3d(){
difference(){
solid_wallet_3d();
translate([wall_thickness,0,material_thickness-card_thickness+0.01])
solid_card_3d();
card_inset_3d();
translate([0,-10,0])
cube([card_width+10,10,material_thickness]);
band_inset_3d();
rotate([0,0,90]) 
if (logo==true){
//tweak logo position below - may be helpful to put a # before the logo() below to make it easier to see the location of the logo
translate([19,-70,0]) 
difference(){//the example logo needed to be reversed so I removed it from a cube but if your logo doesn't need this then you can remove the difference/cube and just do the logo()
cube([36,49.8,2]);
translate([-2,-81,0])
logo(2);
}
}
}
}


module solid_card_3d(){
hull(){
translate([card_radius,0,0])
cylinder(r=card_radius,h=card_thickness);
translate([card_width-card_radius,0])
cylinder(r=card_radius,h=card_thickness);
translate([card_radius,card_length,0])
cylinder(r=card_radius,h=card_thickness);
translate([card_width-card_radius,card_length,0])
cylinder(r=card_radius,h=card_thickness);
}
}

module solid_wallet_3d(){
hull(){
translate([card_radius,0])
cylinder(r=card_radius,h=material_thickness);
translate([card_width-card_radius+2*wall_thickness,0,0])
cylinder(r=card_radius,h=material_thickness);
translate([card_radius,card_length+wall_thickness,0])
cylinder(r=card_radius,h=material_thickness);
translate([card_width-card_radius+2*wall_thickness,card_length+wall_thickness,0])
cylinder(r=card_radius,h=material_thickness);
}
}

module card_inset_3d(){
hull(){
translate([wall_thickness+card_width/2-card_inset_width/2,card_inset_length,0])
cylinder(r=card_radius,h=material_thickness);
translate([wall_thickness+card_width/2+card_inset_width/2,card_inset_length,0])
cylinder(r=card_radius,h=material_thickness);
translate([wall_thickness+card_width/2-card_inset_width/2-2*card_radius,0,0])
cube([card_inset_width+4*card_radius,0.01,material_thickness]);
}
}

module band_inset_3d(){
translate([0,(card_length+wall_thickness)/2-band_inset_length/2,0])
cube([band_inset_width+0.2,band_inset_length,material_thickness]);
translate([2*wall_thickness+card_width-band_inset_width-0.01,(card_length+wall_thickness)/2-band_inset_length/2,0])
cube([band_inset_width+0.02,band_inset_length,material_thickness]);
}

module logo(height) {
    linear_extrude(height = height) {
        scale(1)
        import("IronMan.dxf");
    }
}

module slim_wallet_2d(){
difference(){
solid_wallet();
translate([wall_thickness,0])
difference(){solid_card();card_inset();}
translate([0,-10])
square([card_width+10,10]);
band_inset();
}
square([card_width+2*wall_thickness,0.01]);
}

module solid_card(){
hull(){
translate([card_radius,0])
circle(r=card_radius);
translate([card_width-card_radius,0])
circle(r=card_radius);
translate([card_radius,card_length])
circle(r=card_radius);
translate([card_width-card_radius,card_length])
circle(r=card_radius);
}
}

module solid_wallet(){
hull(){
translate([card_radius,0])
circle(r=card_radius);
translate([card_width-card_radius+2*wall_thickness,0])
circle(r=card_radius);
translate([card_radius,card_length+wall_thickness])
circle(r=card_radius);
translate([card_width-card_radius+2*wall_thickness,card_length+wall_thickness])
circle(r=card_radius);
}
}

module card_inset(){
translate([-card_radius,0])
hull(){
translate([wall_thickness+card_width/2-card_inset_width/2,card_inset_length])
circle(r=card_radius);
translate([wall_thickness+card_width/2+card_inset_width/2,card_inset_length])
circle(r=card_radius);
translate([wall_thickness+card_width/2-card_inset_width/2-2*card_radius,0])
square([card_inset_width+4*card_radius,0.01]);
}
}

module band_inset(){
translate([0,(card_length+wall_thickness)/2-band_inset_length/2])
square([band_inset_width,band_inset_length]);
translate([2*wall_thickness+card_width-band_inset_width,(card_length+wall_thickness)/2-band_inset_length/2])
square([band_inset_width,band_inset_length]);
}
