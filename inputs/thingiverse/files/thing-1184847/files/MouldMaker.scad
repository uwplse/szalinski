// preview[view:north east, tilt:top diagonal]

/* [Show/Hide] */
//Useful for positioning the master
show_axis="Yes"; //[Yes, No]
//The object you are creating a mould for
show_master="No"; //[Yes, No]
//Entry and exit for the casting material
show_sprue_and_riser="No"; //[Yes, No]
//Optional horizontal extension from sprue
include_runner="No"; //[Yes, No]
show_mould_top="Yes"; //[Yes, No]
show_mould_bottom="Yes"; //[Yes, No]
//Set low for quicker editing and high for final render
resolution=36; //[36, 360]

/* [Master Adjustments] */
//Use goo.gl/Aoiphw to convert your master STL in to an OpenSCAD polyhedron and paste the list of points and faces/triangles here
master_points="[]";
master_faces="[]";
master_x_rotation=0; //[-180:180]
master_y_rotation=0; //[-180:180]
master_z_rotation=0; //[-180:180]
master_x_translation=0; //[-100:100]
master_y_translation=0; //[-100:100]
master_z_translation=0; //[-100:100]

/* [Sprue, Runner, and Riser Adjustments] */
sprue_diameter=5; //[5:20]
sprue_x_translation=0; //[-100:100]
sprue_y_translation=-20; //[-100:100]
sprue_z_translation=0; //[-100:100]
runner_angle=0; //[0:360]
runner_length=25; //[1:50]
riser_diameter=5; //[5:20]
riser_x_translation=0; //[-100:100]
riser_y_translation=20; //[-100:100]
riser_z_translation=0; //[-100:100]

/* [Mould Size Adjustments] */
mould_x_dimention=80; //[1:200]
mould_y_dimention=110; //[1:200]
mould_z_dimention=50; //[1:200]

/* [Hidden] */
$fn=resolution;
delta=0.01;

module rounded_edges(){
    radius = 10;
    difference(){
        cube([mould_x_dimention+delta,mould_y_dimention+delta,mould_z_dimention+delta], center=true);

        minkowski(){
            cube([mould_x_dimention-2*radius+delta,mould_y_dimention-2*radius+delta,mould_z_dimention-2*radius+delta], center=true);

            sphere(r=radius);
        }
    }
}

//rounded_edges();

module axis(){
    rotate([0,90,0])
    cylinder(d=1, h=0.5*mould_x_dimention+10);

    rotate([-90,0,0])
    cylinder(d=1, h=1.5*mould_y_dimention+20);

    cylinder(d=1, h=mould_z_dimention);

    translate([0.5*mould_x_dimention+20,0,0])
    //rotate([0,0,180])
    linear_extrude(height=1)
    scale(5)
    //polygon(points=[[-1,0],[-2,1],[-2,2],[-1,2],[0,1],[1,2],[2,2],[2,1],[1,0],[2,-1],[2,-2],[1,-2],[0,-1],[-1,-2],[-2,-2],[-2,-1]]);
    text("X", size=5, font="Russo One", valign="center", halign="center");

    translate([0,1.5*mould_y_dimention+30,0])
    rotate([0,0,90])
    linear_extrude(height=1)
    scale(5)
    //polygon(points=[[-1,0],[-2,1],[-2,2],[-1,2],[0,1],[1,2],[2,2],[2,1],[1,0],[1,-2],[0,-2],[-1,-2]]);
    text("Y", size=5, font="Russo One", valign="center", halign="center");

    translate([0,0,mould_z_dimention+10])
    rotate([0,0,135])
    rotate([90,0,0])
    linear_extrude(height=1)
    scale(5)
    //polygon(points=[[-2,1],[-2,2],[2,2],[2,1],[0,-1],[2,-1],[2,-2],[1,-2],[-1,-2],[-2,-2],[-2,-1],[0,1]]);
    text("Z", size=5, font="Russo One", valign="center", halign="center");
}

module master(){
    translate([master_x_translation,master_y_translation,master_z_translation])
    rotate([0,0,master_z_rotation])
    rotate([0,master_y_rotation,0])
    rotate([master_x_rotation,0,0])
    if (master_points == "[]")
        resize(newsize=[70,100,40])
        sphere(1);
    else
        polyhedron(points=master_points, faces=master_faces);
}

module sprue(){
    translate([sprue_x_translation,sprue_y_translation,sprue_z_translation]){
        cylinder(d1=sprue_diameter, d2=1.5*sprue_diameter,h=mould_z_dimention/2 + 1);

        if (include_runner == "Yes"){
            sphere(d=sprue_diameter);

            rotate([0,0,runner_angle])
            rotate([-90,0,0])
            cylinder(d=sprue_diameter, h=runner_length);
        }
    }
}

module riser(){
    translate([riser_x_translation,riser_y_translation,riser_z_translation])
    cylinder(d=riser_diameter, h=mould_z_dimention/2 + 1);
}

module mould_bottom(){
    difference(){
        union(){
            translate([0,0,-mould_z_dimention/4])
            cube([mould_x_dimention,mould_y_dimention,mould_z_dimention/2], center=true);

            translate([10-mould_x_dimention/2,10-mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2]) sphere(1);

            translate([-10+mould_x_dimention/2,10-mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2]) sphere(1);
        }
        union(){
            master();

            translate([10-mould_x_dimention/2,-10+mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2])
            sphere(1);

            translate([-10+mould_x_dimention/2,-10+mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2])
            sphere(1);

            rounded_edges();
        }
    }
}

module mould_top(){
    difference(){
        union(){
            translate([0,0,mould_z_dimention/4])
            cube([mould_x_dimention,mould_y_dimention,mould_z_dimention/2], center=true);

            translate([10-mould_x_dimention/2,-10+mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2])
            sphere(1);

            translate([-10+mould_x_dimention/2,-10+mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2])
            sphere(1);
        }
        union(){
            master();

            sprue();

            riser();

            translate([10-mould_x_dimention/2,10-mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2])
            sphere(1);

            translate([-10+mould_x_dimention/2,10-mould_y_dimention/2,0])
            resize(newsize=[10,10,mould_z_dimention/2])
            sphere(1);

            rounded_edges();
        }
    }
}

module show_what(){
    if (show_axis == "Yes")
        color("black")
        axis();
    if (show_master == "Yes")
        color("grey")
        master();
    if (show_sprue_and_riser == "Yes"){
        color("grey")
        sprue();

        color("grey")
        riser();
    }
    if (show_mould_top == "Yes")
        translate([0,10+mould_y_dimention,0])
        rotate([180,0,0])
        color("lightgrey")
        mould_top();
    if (show_mould_bottom == "Yes")
        color("lightgrey")
        mould_bottom();
}

show_what();