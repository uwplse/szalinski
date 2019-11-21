

cyl_rad = 3;  //[2:0.1:10]

cyl_hgt = 271;  //[100:1000]

strut_sides=3;  //[3,4,5,6,7,8]

number_of_struts=20;  //[5:100]

angle_of_strut = 45;  //[0:90]

inner_radius = 50; //[10:100]

for(i=[0:1/(number_of_struts):1])
    rotate(i*360,[0,0,1])
    translate([inner_radius,0,0]) 
    rotate(angle_of_strut,[1,0,0])
       cylinder(r=cyl_rad,h=cyl_hgt,center=true,$fn=strut_sides);

for(i=[0:1/(number_of_struts):1])
    rotate(i*360,[0,0,1])
    translate([inner_radius,0,0]) 
    rotate(-angle_of_strut,[1,0,0])
       cylinder(r=cyl_rad,h=cyl_hgt,center=true,$fn=strut_sides);

