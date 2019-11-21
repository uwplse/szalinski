//CUSTOMIZER VARIABLES

//  Number of sides
n = 5; //  [3:30]
//  Radius of the box in mm
r = 30;
//  Length of each arm in mm
l = 10;
//  Height of the box
h = 15;
//  Wall thickness in mm
w = 0.8;
//  Thickness of bottom wall in mm
b_l = 1;
//  Roundness factor
r_f = 0; //[0:10]
//  Generate Box (0) or Lid (1)
Select = 0; //[0:1]

//CUSTOMIZER VARIABLES END

module poly(n_sides, r, l, rnd = 0) {
    r = r - l;
    theta = 360/n_sides;
    //echo(theta);
    pts_1 = [for (i = [0:theta:360]) [r*sin(i),r*cos(i)]];
    //echo(pts_1);
    
    h = r*cos(theta/2);
    s = r*sin(theta/2);
    //echo(h);
    
    pts_2 = [[-s,0],[0,l+(r-h)],[s,0]];
    //echo(pts_2);
    
    if (rnd == 0) {
        union() {
            for (i = [0:360/n_sides:360]) 
                rotate(i)
                union() {
                    rotate([0,0,-theta/2])
                    polygon(pts_1);
                    
                    translate([0,h,0])
                    polygon(pts_2);
                }
        }
    }
    else {
        minkowski(){
            union() {
                for (i = [0:360/n_sides:360]) 
                    rotate(i)
                    union() {
                        rotate([0,0,-theta/2])
                        polygon(pts_1);
                        
                        translate([0,h,0])
                        polygon(pts_2);
                    }
            }
            circle(rnd, $fn = 32);
        }
    }
}

if (Select == 0) {
    // Build the box
    //translate([-1.5*r,0,0])
    union() {
        linear_extrude((8*h/10) - b_l)
        difference() {
            poly(n, r, l, r_f);
            offset(-w)
            poly(n, r, l, r_f);
        }
        linear_extrude(b_l)
        poly(n, r, l, r_f);
    }
}
else {
    // Build the lid
    //translate([1.5*r,0,0])
    union() {
        linear_extrude(2*h/10)
        difference() {
            offset(-w)
            poly(n, r, l, r_f);
            offset(-2*w)
            poly(n, r, l, r_f);
        }
        linear_extrude(h/10)
        poly(n, r, l, r_f);
    }
}