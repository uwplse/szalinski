bearing_diameter = 28;
bearing_height = 8;
coin_diameter = 21.5; //[19.5:Penny, 21.5:Nickel, 18.3:Dime, 24.6:Quarter]
//Select the same coin
coin_thickness = 2.1; //[1.6:Penny, 2.1:Nickel, 1.5:Dime, 1.9:Quarter]
//Optional, set thickness around bearing
thickness = 3;
//Select the part to print
part = "both"; // [first:Spinner Only, second:Plug Only, both:Both Parts]
    
module spinner() {
    $fn = 100;
    offset = 2 * thickness;
    
    coin_count = floor((bearing_height - 2) / coin_thickness);
    coin_depth = coin_count * coin_thickness;
    wall_thickness = (bearing_height - coin_depth) / 2;
    
    circle1_height = (bearing_diameter + coin_diameter + offset) / 2; // Y-axis
    cutout_dia = circle1_height;

    function geta1(r1, r2, k) = k * r2 / (r2 - r1);
    function getAlpha(opposite_side = 1, hypothenuse = 1) = asin(opposite_side / hypothenuse);
    function getC2(a=1, b=1, c=1) = (pow(a,2) + pow(c,2) - pow(b,2)) / (2 * c);
    function getCx0(hip=1, side=1) = sqrt(pow(hip,2) - pow(side,2));

    module body() {
        // Create the trapezoid
        module fillerStuff(s = 1) {
            r1 = (coin_diameter + offset) / 2;
            r2 = (bearing_diameter + offset) / 2;

            a = (2 * r2 + cutout_dia) / 2;
            b = (2 * r1 + cutout_dia) / 2;
            c = circle1_height;
            c2 = getC2(a, b, c);  // Projection of a onto c (y axis)
            c1 = c - c2;   // Projection of b onto c (y axis)
            Cx0 = getCx0(a, c2);
            C0 = [Cx0, c2 * s]; // Tangent circle center
            C1 = [-Cx0, c2 * s]; // Tangent circle center
            x2 = Cx0 * r2 / a;
            y2 = c2 * r2 / a;
            x1 = Cx0 * r1 / b;
            y1 = c - c1 * r1 / b;
    
            // Points that make the trapezoid
            point0 = [-x2, y2 * s];
            point1 = [-x1, y1 * s];
            point2 = [x1, y1 * s];
            point3 = [x2, y2 * s];

            // Draw it
            difference() {
                polygon(points=[point0, point1, point2, point3], paths=[[0,1,2,3]]);
                translate(C0)circle(r = cutout_dia / 2, center = true);
                translate(C1)circle(r = cutout_dia / 2, center = true);
            }
        }
      
        linear_extrude(height = bearing_height, slices = 1) {
            union() {
                circle(r=(bearing_diameter + offset)/2);

                translate([0, circle1_height, 0])
                circle(r=(coin_diameter + offset)/2);
          
                translate([0, -circle1_height, 0])
                circle( r=(coin_diameter + offset)/2);

                fillerStuff();
                fillerStuff(s = -1);
            }
        }
    }
    
    module holes() {
        translate([0, 0, -1])
        cylinder(r=(bearing_diameter)/2, h = bearing_height + 2);

        translate([0, circle1_height, wall_thickness])
        cylinder(r=(coin_diameter)/2, h = bearing_height);
          
        translate([0, -circle1_height, wall_thickness])
        cylinder( r=(coin_diameter)/2, h = bearing_height);
    }
   
    module plugs() {
        translate([circle1_height + offset, 0, 0])
        cylinder(r=(coin_diameter)/2, h = wall_thickness);
       
        translate([-circle1_height - offset, 0, 0])
        cylinder(r=(coin_diameter)/2, h = wall_thickness);
    }
    
    module part() {
        difference() {
            body();
            holes();
        }
    }
    
    if(part == "first") {
        part();
    } else if(part =="second") {
        plugs();
    } else {
        part();
        plugs();
    }
}

spinner();