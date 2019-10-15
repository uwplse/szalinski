// Radius of the sphere
radius = 80; // [1:0.5:400]

// Thickness of the edges
thickness = 10; // [1:0.5:50]

// Width of the edges
width = 5; // [1:0.5:50]

// Number of vertices on the sphere
number_of_vertices = 30; // [1:50]

// Percentage of edges that are connected ( Higher means more edges, make sure you can put the light blob in when you increase this number )
connection_rate = 11; // [1:100]

// Random seed for generating vertices and edges ( Use the same seed to get the same design )
seed = 3; // [1:10000]


// Specification for the adapter to the base
adapter_inner_diameter = 41; // [1:0.5:100]
adapter_mid_diameter = 60; // [1:0.5:100]
adapter_outer_diameter = 80; // [1:0.5:100]
adapter_height = 3; // [1:0.5:20]

translate([0,0,radius]) difference() {
    cylinder(h=adapter_height, d=adapter_outer_diameter, center=true);
    cylinder(h=adapter_height+1, d=adapter_inner_diameter, center=true);
}
difference() {
    random_shade(radius, thickness, number_of_vertices, width, connection_rate,seed);
    translate([0,0,radius]) cylinder(h=thickness*2, d=adapter_mid_diameter, center=true);
    translate([0,0,radius+adapter_height/2]) cylinder(h=thickness*2, d=adapter_outer_diameter);
}
module random_shade(radius, thickness, number_of_vertices, width, connection_rate,seed) {

    random_vect = rands(0,1,number_of_vertices*2 + number_of_vertices*(number_of_vertices-1),seed);

    vertices = [ for (i=[0:number_of_vertices])
                [0,acos(random_vect[i*2]*2-1),random_vect[i*2+1]*360] ];
    vertices_in_c = [for(i=[0:number_of_vertices])
        [ radius*sin(vertices[i][1])*cos(vertices[i][2]), 
                    radius*sin(vertices[i][1])*sin(vertices[i][2]),
                    radius*cos(vertices[i][1])]];
   
    /*
    for(i=[0:number_of_vertices]) {
        azimuth = rands(0,360,1)[0];
        polar = acos(rands(-1,1,1)[0]);
        vertices[i] = [0,polar,azimuth];
        //rotate([0,polar,azimuth]) cylinder(radius*2, width/2, width/2);
    }
    */
//    for(i=[0:number_of_vertices])
//        translate(vertices_in_c[i]) cube(20,20,20, true)
    
    intersection() {
        difference() {
            sphere(radius+thickness);
            sphere(radius);
        }

        for(i=[0:number_of_vertices]) {
            if (i+1 < number_of_vertices) for(j=[i+1:number_of_vertices]) {
                    x3 = vertices_in_c[i][1]*vertices_in_c[j][2] - vertices_in_c[j][1]*vertices_in_c[i][2];
                    y3 = vertices_in_c[j][0]*vertices_in_c[i][2] - vertices_in_c[i][0]*vertices_in_c[j][2];
                    z3 = vertices_in_c[i][0]*vertices_in_c[j][1] - vertices_in_c[j][0]*vertices_in_c[i][1];
                if (abs(z3) / sqrt(pow(x3,2)+pow(y3,2)) < 0.8391)
                if (random_vect[number_of_vertices*2 + (i+1)*j - 1]*100 < connection_rate) hull(){

                    rotate(vertices[i]) cylinder(radius*5, width/2, width/2);
                    rotate(vertices[j]) cylinder(radius*5, width/2, width/2);
                }
            }
        }

    }
}

