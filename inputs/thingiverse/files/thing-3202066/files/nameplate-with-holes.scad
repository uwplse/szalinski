//Original was https://www.thingiverse.com/thing:1731842
//Modified to add drill_holes module to include mounting holes
//
//

text="Hank Cowdog";
text_font="Fontdiner Swanky";//[Courier New:Courier New,Open Sans:Open Sans,Indie Flower:Indie Flower,Lobster:Lobster,Poiret One:Poiret One,Pacifico:Pacifico,Dancing Script:Dancing Script,Kaushan Script:Kaushan Script,Chewy:Chewy,Black Ops One:Black Ops One,Fruktur:Fruktur,Creepster:Creepster,Fontdiner Swanky]

text_z_height=1;
text_size=7;

tag_z_height=1;
tag_height=25;
tag_width=80;

frame_thickness=2;

MountingHoles = 2;				// [2:1/8" ,3: 3/16", 4:1/4", 0:None]

//MountingHoles = # of 1/16ths that make up the hole diameter
// if zero then no holes
hole_diameter= (25.4/16*MountingHoles);

//place the holes one "frame_thickness" inside the inner part of the plate
//and centered top to bottom
hole_xpos = tag_width/2-frame_thickness-hole_diameter/2.0;
zfudge=0.01+10.0;  // used to insure the cylinder clears the plate on top and bottom

union() {
    //plate back
    difference() {
        linear_extrude(tag_z_height){
            resize([tag_width,tag_height,1]) form();
            }
        // Mounting Holes
        if(MountingHoles> 0) drill_holes();
    }
    // text and frame
    translate([0,0,tag_z_height]){
        linear_extrude(text_z_height){
            text(text,font=text_font, halign="center", valign="center", size=text_size);
        }

        difference(){
            linear_extrude(text_z_height){
                resize([tag_width,tag_height,1]) form();
                }
            linear_extrude(text_z_height+2){
                resize([tag_width-frame_thickness,tag_height-frame_thickness,1]) form();
            }
        }
     }
 }
// New Module by Hank Cowdog to include mounting holes when requested
module drill_holes(){

    translate([-hole_xpos,0.0,0-zfudge/2.0]){ 
        cylinder($fn=32,h=tag_z_height+zfudge,r=hole_diameter/2);
    }
    translate([hole_xpos,0.0,0-zfudge/2.0]){ 
        cylinder($fn=32,h=tag_z_height+zfudge,r=hole_diameter/2);
    }
}

module form(){
difference(){
square([45,25],center=true);


translate([22.5,12.5,0]) circle(5,$fn=120);
translate([-22.5,12.5,0]) circle(5,$fn=120);
translate([-22.5,-12.5,0]) circle(5,$fn=120);
translate([22.5,-12.5,0]) circle(5,$fn=120);
}
}
