// Degree of the ruler
degree=45; //[15:80]

// Width of the ruler
width=50;

// Length of the connector between alignment base and angled ruler
connector_length=30;

// Thickness of the ruler.
thickness=1;

/* [Text] */

// Do you want to add degree as text to the ruler
show_text = 1; //[1:Yes,0:No]

// Thinckness of the text
text_thickness = 1;

/* [Advanced] */

// Length of the base that helps with alignment.
base_length = 15;

// Width of the base to angled ruler connector
connector_width = 10;

// Notch on the side of the ruler. Helps to maintain ruler alignment. Additionally, it helps while printing as extremely thin parts do not print good enough.
ruler_notch = 5;

/* [Hidden] */

translate([0, connector_length+base_length, 0])
linear_extrude(thickness)
polygon([
    [0,0], 
    [width,0],
    [width, ruler_notch],
    [0,ruler_notch+tan(degree)*width]
]);

//Connector
translate([(width-connector_width)/2,base_length,0])
cube([connector_width,connector_length,thickness]);

//Base
cube([width,base_length,thickness]);

//Text
if(show_text) {
    translate([width/2, base_length/3/2, 0])
    linear_extrude(thickness+text_thickness)
    scale([base_length/15, base_length/15, 1])
    text(str(degree, "°"), halign="center");
}