//count of fragments for cylinders etc.
$fn=60; 
//length, min. 70mm
length=80; 

//upper holder diameter
SHDia2=23.6;
//lower holder diameter
SHDia1=20; 

difference() {
    cube([length,40,60]);
    //Neckline above - Ausschnitt oben
    translate([10,45,70]){
        rotate([90,90,0]) {
            linear_extrude(height = 50, center = false, convexity = 10, twist = 0)
            polygon(points=[[0,0],[50,15],[50,length],[0,length]]);
        }
    }
    
    //Holder hole (slightly larger than the part of the showerhead)
    translate([length-6,20,-1])
    cylinder(30,d1=SHDia1,d2=SHDia2);
    
    //hole screw
    translate([14,20,50]) {
        rotate([0,90,0]) {
        cylinder(30,2,2,center=true);
        cylinder(24,5,5,center=true);
        }
    }
    //hole screw below
    translate([9,20,10]) {
        rotate([0,90,0]) {
        cylinder(20,2,2,center=true);
        cylinder(14,5,5,center=true);
        }
    }
    //wedge cut below
    translate([4,20,20]){
        rotate([90,90,0]) {
            linear_extrude(height = 30, center = true, convexity = 10, twist = 0)
            polygon(points=[[0,0],[21,0],[21,60]]);
        }
    }
}

//some fixation
translate([-0.5,20,15])
cube([1,1,3],center=true);

