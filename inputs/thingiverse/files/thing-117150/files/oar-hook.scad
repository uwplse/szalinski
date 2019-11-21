//Open-source oar hook

// Radius of screw hole
r=2; //[1:10]
//Width of oar
w=35; //[30:60]
//Angle of hook
a=15; //[5:45]
// Inner angle of hook
i=5; //[5:10]
// height of hook
h=35;
//resolution of render
z=60;

translate([0,0,-w*1/6])difference(){
union(){
hull() {
   translate([-w*3/4,0,0]) sphere(r=w/2, $fn=z);
    translate([w*3/4,0,0])sphere(r=w/2, $fn=z);
 }

rotate([-a,-i,0])union(){
translate([w*3/4,0,h/4])cylinder(h = h, r1 = w/4, r2 = w/8, center = false, $fn=z); //right hook
translate([w*3/4,0,h+h/4])sphere(r=w/8, $fn=z);
		}

rotate([-a,i,0])union(){
translate([-w*3/4,0,h/4])cylinder(h = h, r1 = w/4, r2 = w/8, center = false, $fn=z);//left hook
translate([-w*3/4,0,h+h/4])sphere(r=w/8, $fn=z);
		}

}
cylinder(h=w, r=r+1, center=true); //screw hole
translate([0,0,-w*1/3])cube([3*w,w,w], center=true);
}


//rotate([-a,0,0])%rotate([-a,0,0])