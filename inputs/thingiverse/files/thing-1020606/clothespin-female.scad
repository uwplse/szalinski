/////////////////////////////
// SETTINGS

// preview[view:north, tilt:side]
resolution = 40 *1;
head_radius = 9.0; //[7.0:0.1:11.0]
neck_size = 3.0; //[2:0.1:5]
torso_radius = 13; // [10:0.1:25]
torso_x = 0 * 1;
torso_height = 35; // [0:5:50]
hip_radius = 18; // [10:0.1:25]
hip_x = 0 * 1;
hip_z = 0 *1;
//Decrease if waist disappears
waist_tangent = 5.0; // [1.0:0.1:10.0]
leg_length = 80; // [45:5:100]



/////////////////////////////
// MATH

inner_leg = leg_length * .9;
meta_radius = (hip_radius + torso_radius)/waist_tangent;
force1 = hip_radius + meta_radius;
force2 = torso_radius + meta_radius;
force_distance = sqrt(((hip_x - torso_x)*(hip_x - torso_x)) + ((hip_z - torso_height)*(hip_z - torso_height)));
donutz = (( force1 * force1 ) - ( force2 * force2 ) + ( force_distance * force_distance ))/( 2 * force_distance );
donutx = sqrt(( force1 * force1 ) - ( donutz * donutz ));
side1 = sqrt((donutz * donutz) + (donutx * donutx));
taperBottomz = (hip_radius/side1) * donutz;
taperBottomx = (hip_radius/side1) * donutx;
side2 = abs(torso_height - donutz);
taperTopz = torso_height-((torso_radius/force2) * side2);
taperTopx = (torso_radius/force2) * donutx;
taperExtrude = abs(taperBottomz - taperTopz);
taperAmount = taperTopx/taperBottomx;


/////////////////////////////
// RENDER

translate([0,0,torso_height+torso_radius+hip_radius-head_radius])
  cylinder(r=neck_size, h=head_radius*2, $fn=resolution);

translate([0,0,torso_height+torso_radius+hip_radius+((head_radius/2)*2)])
  sphere(r=head_radius);

translate([0,0,hip_radius])
  metaBalls();

module metaBalls(){

  if (force_distance > force1 + force2){  
    echo (str("Circles are too far apart. No Metaball Allowed"));
  }

  else if(force_distance < abs(force1-force2)){
    echo (str("Circle contained inside. No Metaball Allowed"));
  }

  else if(force_distance==0 && force1==force2){
    echo (str("These are the same circle. No Metaball Allowed"));
  }
  else{
    difference(){
      tangent();
      donut();
    }
  };

  difference(){
    hull(){
      translate([0,0, -leg_length])
        cylinder(r=5);
      
      translate([hip_x,0,hip_z])
        sphere(r=hip_radius, $fn=resolution);
    }

    union()  
      translate([0,0, -leg_length])
        linear_extrude(height=inner_leg, scale=1.5)
          square(size=[2,100], center=true);
       translate([0,0, inner_leg - leg_length])
        rotate([90, 0,0])
          cylinder(r=1.5, h=100, center=true, $fn=resolution);
  }

  translate([torso_x,0,torso_height])
    sphere(r=torso_radius, $fn=resolution);
}

/////////////////////////////
// MODULES

module donut(){
  translate([0,0,donutz])
    rotate_extrude(convexity = 10, $fn=resolution)
      translate([donutx, 0 ,0])
        circle(r=meta_radius, $fn=resolution, center=true);
}

module tangent(){
  translate([ 0,0,taperBottomz ])
    linear_extrude(height=taperExtrude, scale=taperAmount)
      circle(r=taperBottomx, $fn=resolution, center=true);
}
  
  
