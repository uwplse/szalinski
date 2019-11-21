//http://www.thingiverse.com/thing:57711/edit
//by allenZ
//NC-SA
//

use <MCAD/fonts.scad>



message = "allenZ";
font_size = 10;
font_spacing = -1.8;
tolerance = 0.4;


thisFont=8bit_polyfont();
x_shift=thisFont[0][0];
y_shift=thisFont[0][1];

scale = font_size/y_shift;


stick_radius = font_size/2*0.8;
stick_length = (font_size+font_spacing*scale)*len(message)+4;

hanger_radius = stick_radius;

head_radius = hanger_radius-1.2;

z_ratio = (2+tolerance*2)/2;

echo (len(message));

echo (x_shift);
echo (y_shift);

$fn=50;


theseIndicies=search(message,thisFont[2],1,1);


translate ([-stick_length/2-tolerance,0,0])
rotate ([0,-90,0]) hanger();

stickwithconnect();


module stickwithconnect() {
union () {
stick();
translate ([-stick_length/2-2-tolerance,0,0])
rotate ([0,-90,0]) 
connecthead();
}
}

module connecthead() {//length=4mm+tolerance
union() {
cylinder(r=head_radius,h=2);
translate ([0,0,-2-tolerance]) cylinder(r=head_radius-0.6,h=2+tolerance*2);
}
}


module stick() {
union () {
intersection() {
scale ([scale,scale,scale])
translate ([-len(message)*(x_shift+font_spacing)/2,-y_shift/2,0])
linear_extrude(height = y_shift, center=true)
for (i=[0:len(message)-1]) {
translate ([i*(x_shift+font_spacing),0,0])
polygon(points=thisFont[2][theseIndicies[i]][6][0],paths=thisFont[2][theseIndicies[i]][6][1]);
}

rotate ([0,90,0]) cylinder (r=font_size/2,h=stick_length,center=true);
}
rotate ([0,90,0]) cylinder (r=stick_radius,h=stick_length,center=true);
}
}

module hanger() {
translate ([0,0,+2-tolerance])
difference () {
translate ([0,0,-2+tolerance])
difference () {
union() {
cylinder (r=hanger_radius,h=6);
translate ([0,0,6]) sphere (r=hanger_radius);
}
//cut the hole
translate ([0,0,6]) rotate ([0,90,0]) cylinder (r=2,h=hanger_radius*2,center=true);
}

//cut the connecting part
scale ([(head_radius+tolerance)/head_radius,(head_radius+tolerance)/head_radius,z_ratio])
connecthead();
}
}