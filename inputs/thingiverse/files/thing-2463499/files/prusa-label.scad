
name = "PRINTER 02"; // Printer name
width = 70; // tag width
height = 20; // tag height

text_size = 10; // text size
text_thickness = 2;
font="Marker Felt:style=Thin";
thickness = 3;


module base() {
    translate([0,6.3+thickness,0]) cube([width,thickness,height], center=true);
    translate([0,(6.3+thickness*2)/2-thickness/2,height/2]) cube([width,6.3+thickness*2,thickness], center=true);
    cube([width,thickness,height], center=true);
}

module render_text() {
    translate([-width/2+text_size/4,-thickness/2+text_thickness-0.1,-text_size/2]) rotate([90,0,0]) linear_extrude(text_thickness) text(name, size=text_size, font=font);
}

difference() {
    base();
    render_text();
    
    translate([0,6.3+text_thickness/2+thickness-text_thickness/2,0]) rotate([0,0,180]) render_text();
}
