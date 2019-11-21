//Pencil Holder

//Height Of Holder
HeightHolder = 100;

//Slices Of Twists
Slices = 360;

//X, Y Place Where Holes Are
Holes = 10;

//Radius Of Pencil Hole
Radius = 4.5;

difference(){
    union(){
        linear_extrude(height = HeightHolder, twist = 180, scale = 1, slices = Slices)
            translate([Holes,Holes]){
                square([10, 10]);
            }
        linear_extrude(height = HeightHolder, twist = -180, scale = 1, slices = Slices)
            translate([-Holes*2,-Holes*2]){
                square([10, 10]);
            }
        linear_extrude(height = HeightHolder, twist = -180, scale = 1, slices = Slices)
            translate([Holes,Holes]){
                square([10, 10]);
            }
        linear_extrude(height = HeightHolder, twist = 180, scale = 1, slices = Slices)
            translate([-Holes*2,-Holes*2]){
                square([10, 10]);
            }
        translate([Holes*1.5,Holes*1.5,0]){
            linear_extrude(height = HeightHolder, twist = 360, scale = 1, slices = Slices)
                square([10,10],center=true);
        }
        translate([-Holes*1.5,-Holes*1.5,0]){
            linear_extrude(height = HeightHolder, twist = 360, scale = 1, slices = Slices)
                square([10,10],center=true);
        }
        translate([-Holes*1.5,Holes*1.5,0]){
            linear_extrude(height = HeightHolder/2, twist = 180, scale = 1, slices = Slices)
                square([10,10],center=true);
        }
        translate([Holes*1.5,-Holes*1.5,0]){
            linear_extrude(height = HeightHolder/2, twist = 180, scale = 1, slices = Slices)
                square([10,10],center=true);
        }
    }
    translate([Holes*1.5,Holes*1.5,0]){
        cylinder(HeightHolder,Radius,Radius,$fn = 100);
    }
    translate([-Holes*1.5,-Holes*1.5,0]){
        cylinder(HeightHolder,Radius,Radius,$fn = 100);
    }
    translate([-Holes*1.5,Holes*1.5,0]){
        cylinder(HeightHolder,Radius,Radius,$fn = 100);
    }
    translate([Holes*1.5,-Holes*1.5,0]){
        cylinder(HeightHolder,Radius,Radius,$fn = 100);
    }  
}