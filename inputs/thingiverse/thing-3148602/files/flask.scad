//Bolt head diamter with clearance for tool
B=25;

// Bolt head height
h=8;

// Bolt overall length
l=69.5;

// diamter
d=11;

//Height of Flask  
h1=100;

//Height of Lower Bolt Hole  
h2=25;

//Height of Upper Bolt Hole   
h3=75;

module bolt(){
union(){
		translate([0,0,l-0.1])cylinder(h=h, r=B/2); //space for head
		cylinder(h=l, r=d/2); // bolt shaft
		}
					}
                    


difference(){
union(){
    union(){
    difference(){
    union(){
        translate([250.025,0,0]){
        cylinder(h=h1,r1=250,r2=250,center=false,$fn=50);
        }
    }
    union(){
        translate([250,0,0]){
        cylinder(h=h1,r1=230.005,r2=230.005,center=false,$fn=50);
        }
        translate([276,0,50]){
        cube(size=[500,500,h1],center=true);
        }
        rotate(a=-13,v=[0,0,1])
        translate([10,85,50]){
        cube(size=[50,75,h1],center=true);
        }
        rotate(a=13,v=[0,0,1])
        translate([10,-85,50]){
        cube(size=[50,75,h1],center=true);
        }
    }
}
}
    union(){
    translate([14.25,45,0]){
        cylinder(h=h1,r1=10,r2=10,center=false,$fn=50);
    }
    translate([14.25,-45,0]){
        cylinder(h=h1,r1=10,r2=10,center=false,$fn=50);
    }
    translate([10,0,h1]){
        cylinder(h=6,r1=8,r2=8,center=false,$fn=50);
    }
    translate([10,0,h1+6]){
        cylinder(h=5,r1=8,r2=8,center=false,$fn=50);
        }
        translate([10,0,h1+8.5]){
        for(r=[0:30]){
            rotate([0,0,r*360/30])translate([8,0,0])cube([.5,.5,5],center=true);
    }
}
}
}       
union(){
 translate([-69.5+20-6,0,h3]){
  rotate(a=90,v=[0,1,0])   
bolt();
 }
 translate([-69.5+20-6,0,h2]){
  rotate(a=90,v=[0,1,0])   
bolt();
 }
}
}
