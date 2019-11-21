/* [Bearing Body] */
height = 24; //[1:100]
inner_Radius = 4; //[1:30]
outer_Radius = 7.5; //[3:40]
wall_Thickness = 2; //[1:35]

/* [Sliders] */
slider_Radius = 4; //[1:50]
number_Of_Sliders = 4; //[1:12]

/* [Options] */
degrees_Rotate = 180; //[1080]
quality = 550; //[30:Low, 50:Standard, 80:Fine, 100:Finer, 150:Finest

///
///linear_extrude(height,center=true)
///    circle(inner_Radius,$fn=quality);
///

theta = 360/number_Of_Sliders;
function mod(a,m) = a-m*floor(a/m);

module starter() {
    translate([(slider_Radius*cos(theta))+(inner_Radius*cos(theta)),(slider_Radius*sin(theta))+(inner_Radius*sin(theta)),0])
        circle(slider_Radius,$fn=quality);
}

module one() {
    for (i = [1:(number_Of_Sliders/2)]) {
        rotate([0,0,i*theta]) {
            starter();
        }
    }
}

module two(One_If_Odd) {
    rotate([0,0,((number_Of_Sliders-One_If_Odd)*(theta/2))])
        one();
    if (One_If_Odd == 1) { 
        starter();
    }
}

module circles() {
    one();
    if (mod(number_Of_Sliders,2)==0) {
        two(0);
    } else {
        two(1);
    }
}

module clearOuter() {
    difference() {
        circles();
        difference() {
            circle(inner_Radius + 2*slider_Radius + 1);
            circle(outer_Radius);
        }
    }
}

module outerRing() {
    difference() {
        circle(outer_Radius);
        circle(outer_Radius-wall_Thickness);
    }
}

module base() {
    union() {
        clearOuter();
        outerRing();
    }
}

module 3D() {
    linear_extrude(height = height, center = true, twist = degrees_Rotate, $fn=quality) {
        base();
    }
}
3D();