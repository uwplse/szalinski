text="Your Name";
text_font="Fontdiner Swanky";//[Courier New:Courier New,Open Sans:Open Sans,Indie Flower:Indie Flower,Lobster:Lobster,Poiret One:Poiret One,Pacifico:Pacifico,Dancing Script:Dancing Script,Kaushan Script:Kaushan Script,Chewy:Chewy,Black Ops One:Black Ops One,Fruktur:Fruktur,Creepster:Creepster,Fontdiner Swanky]

text_z_height=1;
text_size=7;

tag_z_height=1;
tag_height=25;
tag_width=60;

frame_thickness=2;


linear_extrude(tag_z_height){
	resize([tag_width,tag_height,1]) form();
}

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

module form(){
difference(){
square([45,25],center=true);


translate([22.5,12.5,0]) circle(5,$fn=120);
translate([-22.5,12.5,0]) circle(5,$fn=120);
translate([-22.5,-12.5,0]) circle(5,$fn=120);
translate([22.5,-12.5,0]) circle(5,$fn=120);
}
}