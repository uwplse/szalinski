// Type of bubble frame
frame_type=1; // [1:Tetrahedron, 2:Octahedron, 3:Triangle Prism, 4:Hexahedron (cube), 5:Pentagon Prism, 6:Hexagon Prism]
// Length of edges in mm
edge_length=76.2;
// Length of handle in mm
handle_length=50;
// Radius of edges and handle
edge_radius=1.5875;

/* [Hidden] */
resolution=15;

// tetra
if (frame_type==1) {
  assign (numsides=3)
  {
  assign (radius2=(edge_length/2)/(sin((360/numsides)/2))) {
  assign (angle=360/numsides, angle2=90-(180/numsides), adjustup=sqrt(pow(radius2,2)-pow((edge_length/2),2))+1.2, numrotation=(((numsides-3)/2)-(((numsides-3)%2)*0.5))) {

    difference() {
      translate([0,0,1.2]) rotate(a=[-90,0,0]) union() {
        for (i=[angle:angle:360.1]) {
          assign (x=(radius2*cos(i)), y=0, z=(radius2*sin(i)), current_angle=(-1*(i+(angle/2))))
          {
          translate([x,y,z]) rotate(a=[0,current_angle,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y,z]) rotate(a=[55,current_angle-30,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y,z]) rotate(a=[55,current_angle-30,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y,z]) sphere(edge_radius, $fn=resolution); 
          }
          translate([0,-(edge_length*cos(35)),0]) rotate(a=[90,0,0]) cylinder(h = handle_length, r=edge_radius, center = false, $fn=resolution);
        }
      }
      translate([-5-edge_length/2,-5-edge_length/2,-6]) rotate(a=[0,0,0]) cube(size = [edge_length+15,edge_length+15,6], center = false, $fn=resolution);
    }
  }
  }
  }
}

// octo
else if (frame_type==2) {
  assign (numsides=4)
  {
  assign (radius2=(edge_length/2)/(sin((360/numsides)/2))) {
  assign (angle=360/numsides, angle2=90-(180/numsides), adjustup=sqrt(pow(radius2,2)-pow((edge_length/2),2))+1.2, numrotation=(((numsides-3)/2)-(((numsides-3)%2)*0.5))) {
  
  difference() {
      translate([0,0,((edge_length/2)*cos(35))]) rotate(a=[45,35,0]) union() {
        for (i=[angle:angle:360.1]) {
          assign (x=(radius2*cos(i)), y=0, z=(radius2*sin(i)), current_angle=(-1*(i+(angle/2))))
          {
          translate([x,y,z]) rotate(a=[0,current_angle,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y,z]) rotate(a=[45,current_angle-45,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y,z]) rotate(a=[-45,current_angle-45,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y,z]) sphere(edge_radius, $fn=resolution); 
          }
          translate([0,edge_length*cos(45),0]) sphere(edge_radius, $fn=resolution); 
          translate([0,-edge_length*cos(45),0]) sphere(edge_radius, $fn=resolution); 
          translate([0,0,edge_length*cos(45)]) cylinder(h = handle_length, r=edge_radius, center = false, $fn=resolution);
        }
      }
      translate([-5-edge_length/2,-5-edge_length/2,-6]) rotate(a=[0,0,0]) cube(size = [edge_length+15,edge_length+15,6], center = false, $fn=resolution);
    }
  }
  }
  }
}


// prisms
else {
  assign (numsides=frame_type)
  {
  assign (radius2=(edge_length/2)/(sin((360/numsides)/2))) {
  assign (angle=360/numsides, angle2=90-(180/numsides), adjustup=sqrt(pow(radius2,2)-pow((edge_length/2),2))+1.2, numrotation=(((numsides-3)/2)-(((numsides-3)%2)*0.5))) {

    difference() {
      translate([0,-(edge_length/2),adjustup]) rotate(a=[0,angle2-numrotation*angle,0]) union() {
        for (i=[angle:angle:360.1]) {
          assign (x=(radius2*cos(i)), y=0, z=(radius2*sin(i)), current_angle=(-1*(i+(angle/2))))
          {
          translate([x,y,z]) rotate(a=[0,current_angle,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y,z]) sphere(edge_radius, $fn=resolution); 
          translate([x,y,z]) rotate(a=[-90,current_angle,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y+edge_length,z]) rotate(a=[0,current_angle,0]) cylinder(h = edge_length, r=edge_radius, center = false, $fn=resolution);
          translate([x,y+edge_length,z]) sphere(edge_radius, $fn=resolution); 
          }
        }
        translate([radius2*cos(angle),(edge_length/2),radius2*sin(angle)]) rotate(a=[0,90-angle,0]) cylinder(h = handle_length, r=edge_radius, center = false, $fn=resolution);
      }
      translate([-5-edge_length/2,-5-edge_length/2,-6]) rotate(a=[0,0,0]) cube(size = [edge_length+15,edge_length+15,6], center = false, $fn=resolution);
    }
  }
  }
  }
}
/**/