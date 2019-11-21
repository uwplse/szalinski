//Easy scale change, Link to link spacing will be 12.74mm with default values.  (spacing=scale*DIA*(1/2+1/sin(THETA))
scale=1; 
//Diameter of major loops (DIA) (default=7.2mm)
loop_diameter = 7.2;
//Thickness of loops (default =2.8mm)
loop_thickness = 2.8;
//Angle at which loops attach to center point (THETA) (default=52)
center_angle = 52; //[20:90]
//Cut a flat in the top of the link (0=no flat, 100=half way thru) (default=0)
top_flat = 0;  //[0:100]
//Cut a flat in the bottom of the link (0=no flat, 100=half way thru) (default=15)
bottom_flat = 15; //[0:100]
//Quality of render (default=20)
fineness = 20; //[4:20] 
//Number of links in X direction (limited for Customizer, use OpenSCAD for more links)
x_link_number = 2; //[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
//Number of links in Y direction (limited for Customizer, use OpenSCAD for more links)
y_link_number = 2; //[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]

//scale=spacing/12.7369;
$fn=fineness;
rad=loop_diameter/2*scale;
thk = loop_thickness/2*scale;
xsteps =x_link_number;  //x repeat for initial group 
ysteps =y_link_number;  //y repeat for initial group
theta=center_angle;

top_hgt=(rad*sin(45)+thk)*(100-top_flat)/100;
bottom_hgt=(rad*sin(45)+thk)*(100-bottom_flat)/100;

space=rad/sin(theta)*2;
xpoly=rad+thk;
ypoly=xpoly/tan(theta);


module donut(){
translate([space/2,0,0])
 rotate([45,0,0])
  union(){
    difference(){  
        rotate_extrude()
            translate([rad,0,0])
                    circle(r=thk);
        linear_extrude(height=thk*2, center=true)
            polygon(points=[[0,0],[-xpoly,ypoly],[-xpoly,-ypoly]], paths=[[0,1,2]],convexity=6);

        }

    translate([-rad/sin(theta),0,0])rotate([0,90,theta])cylinder(rad/tan(theta),thk,thk);
    translate([-rad/sin(theta),0,0])rotate([0,90,-theta])cylinder(rad/tan(theta),thk,thk);
 }
}


module link(){
    intersection(){
    translate([-space*1.5,-space*1.5,-bottom_hgt]) cube([space*3,space*3,bottom_hgt+top_hgt],center=false);
    union(){
        rotate([0,0,0]) donut();
        rotate([0,0,90]) donut();
        rotate([0,0,180]) donut();
        rotate([0,0,270]) donut();

        } 
    }
}

x_link = space+rad;
y_link = space+rad;

for(nx=[0:xsteps-1]){
    for(ny=[0:ysteps-1]){
        translate([nx*x_link,ny*y_link,0]) link();
    }
}

echo("Link-to-link spacing", x_link," mm");
echo("Total height =",bottom_hgt+top_hgt,"mm");
echo("Total length=",xsteps*x_link+rad*2+thk*2,"mm");
echo("Total width=",ysteps*y_link+rad*2+thk*2,"mm");


