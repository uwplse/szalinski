include <write.scad>


/////////// START OF PARAMETERS /////////////////

// Inner radius
inner_radius=4.1;

// Body height
body_height=10;

// Text
text="name";

// Radius of facets
facet_radius=1;

// # of spikes 
aantal_spikes=6;

// Height of spikes
hoogte_spikes=10;

/////////// END OF PARAMETERS /////////////////

outer_radius=inner_radius+2;

$fn=20;
pi=3.1415926;
pi2=pi*2;


// Flens Top
translate([0,0,-(body_height/2)+facet_radius]){
	difference(){
		rotate_extrude()
		translate([outer_radius, 0, 0])
			circle(r = facet_radius,$fn=15);
			rotate_extrude()
				translate([outer_radius-(2*facet_radius), -facet_radius, 0])
				square(2*facet_radius);
				}
	}

// Flens Bottom
translate([0,0,(body_height/2)-facet_radius]){
	difference(){
		rotate_extrude()
		translate([outer_radius, 0, 0])
			circle(r = facet_radius,$fn=15);
			rotate_extrude()
				translate([outer_radius-(2*facet_radius), -facet_radius, 0])
				square(2*facet_radius);
				}
	}

//Gems    3 gems=[5:7]  5 gems=[4:8]
for (i = [5:7]) {
	translate([sin(360*i/6)*(outer_radius-.5), cos(360*i/6)*(outer_radius-.5), 0 ]) sphere(r = body_height/7.5,$fn=6);
}

//Body
difference(){
translate([0,0,0]){
cylinder(r=outer_radius,h=body_height,center=true);
writecylinder(text,[0,0,0],t=1.5,outer_radius,center=true);
}
cylinder(r=inner_radius,h=body_height,center=true);
translate([0,0,-0.5*body_height+6.35]) cylinder(r=4.7,h=4); //Inkeping tbv connector
}


//Spikes

difference(){
translate([0, 0, .499*body_height]) {
	for (i = [0:aantal_spikes]) {
		rotate([90,0,360/aantal_spikes*i])
		linear_extrude(height = outer_radius, center = false)
			polygon(points=[[-pi*inner_radius/aantal_spikes,0],[pi*inner_radius/aantal_spikes,0],[0,hoogte_spikes]]);
		}
	}

cylinder(r=inner_radius,h=body_height+3*hoogte_spikes,center=true);        //Cut out spikes inner 
difference(){cube(200,center=true);cylinder(h=50,r=outer_radius,$fn=20);}  //Cut out spikes outer 
}

//Pearls on top of spikes
pos=(outer_radius-inner_radius)/2+inner_radius;
translate([0, 0, 0]) {
	for (i = [0:aantal_spikes]) {
translate([sin(360*i/aantal_spikes)*(pos), cos(360*i/aantal_spikes)*(pos),.5*body_height+hoogte_spikes-1])
sphere(1.5,$fn=10);
}}
