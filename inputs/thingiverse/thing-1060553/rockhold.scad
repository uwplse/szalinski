
module ball(){sphere(d=35, $fn=50);
}

module base(){
difference ()
{sphere(d = 80, $fn=50);    
    translate([0,0,-37])
union(){
		translate([0,0,69.5-0.1])cylinder(h=8, r=12.5); 
		cylinder(h=69.5, r=5.5);
		}
}}


module whole(){
union(){base();
    translate([0,40,0]) ball();
    translate([0,-40,0]) ball();
    translate([40,0,0]) ball();
    translate([-40,0,0]) ball();
    
    translate([40*sin(45),40*sin(45),0]) ball();
    translate([-40*sin(45),40*sin(45),0]) ball();
    translate([40*sin(45),-40*sin(45),0]) ball();
    translate([-40*sin(45),-40*sin(45),0]) ball();
    
    
    
    a=35;
    translate([a*sin(67.5),a*sin(22.5),40*sin(22.5)]) ball();
    translate([a*sin(67.5),a*sin(-22.5),40*sin(22.5)]) ball();
    translate([a*sin(-67.5),a*sin(22.5),40*sin(22.5)]) ball();
    translate([a*sin(-67.5),a*sin(-22.5),40*sin(22.5)]) ball();
    
    translate([a*sin(22.5),a*sin(67.5),40*sin(22.5)]) ball();
    translate([a*sin(22.5),a*sin(-67.5),40*sin(22.5)]) ball();
    translate([a*sin(-22.5),a*sin(67.5),40*sin(22.5)]) ball();
    translate([a*sin(-22.5),a*sin(-67.5),40*sin(22.5)]) ball();
    
    

    b=25;
    translate([b*sin(0),b*sin(90),40*sin(45)]) ball();
    translate([b*sin(0),b*sin(-90),40*sin(45)]) ball();
    translate([b*sin(90),b*sin(0),40*sin(45)]) ball();
    translate([b*sin(-90),b*sin(0),40*sin(45)]) ball();
    
    translate([b*sin(45),b*sin(45),40*sin(45)]) ball();
    translate([-b*sin(45),b*sin(45),40*sin(45)]) ball();
    translate([b*sin(45),-b*sin(45),40*sin(45)]) ball();
    translate([-b*sin(45),-b*sin(45),40*sin(45)]) ball();

}}

module half()
difference ()
{whole();
translate ([0,0,-40]) cube([200,200,80], center=true);
}

difference ()
{half();
    translate([0,0,-37])
union(){
		translate([0,0,69.5-0.1])cylinder(h=8, r=12.5); 
		cylinder(h=69.5, r=5.5);
		};
    }
    

