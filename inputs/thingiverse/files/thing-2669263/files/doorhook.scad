a = 32; 
b = 40; 
height = 20; 
a_thickness = 1;
b_thickness = 2.5;
bump = 2;
c = 50;
d = 20;
e = 15;


cube ([a+2*b_thickness, a_thickness, height]);

translate([a+b_thickness,0,0])
rotate (-90)
cube ([b, b_thickness, height]);

rotate (-90)
cube ([c, b_thickness, height]);

difference(){
translate ([-e/2,-c+0.000001,0])
scale ([1, (d+2*b_thickness)/(e+2*b_thickness),1])
difference(){
    cylinder (d=e+2*b_thickness, h = height);
    rotate(90)
    translate([0,0,-0.1*height])
    cube([d+3*b_thickness, d+3*b_thickness, 3*height]);
}

translate ([-e/2,-c + d/2,0])
cube ([e, d, 3*height], center = true);



translate ([-e/2,-c,0])
scale ([1, d/e,1])
cylinder (d=e, h = 3*height, center = true);
}


angle = 40;

translate([-e,-c,0])
rotate([0,-90,0])
linear_extrude(height = b_thickness){
polygon([[0,0],[height,0],[height/2,1/tan(angle)*height/2]]);
}


translate([b_thickness/2,a_thickness,0])
scale([1,bump/b_thickness,1])
cylinder (d = b_thickness, h = height, $fn = 20);


translate([b_thickness*1.5+a,a_thickness,0])
scale([1,bump/b_thickness,1])
cylinder (d = b_thickness, h = height, $fn = 20);