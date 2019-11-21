sq_size = 6.55;
sq_height = 4.0;
tr_side = 9.1;
tr_height = 4;

cy_d = 11;
cy_height = tr_height + sq_height; //8
//translate([0,0,-cy_height]) cylinder(h=cy_height,d1=13,d2=13, center=false);
//translate([0,0,-cy_height]) cube([sq_size,sq_height,sq_size], center=true);


function move(point,d,angle) =[point[0]+(sin(angle)*d), point[1]+(cos(angle)*d)];

tr_main = 4.8;
tr_side_gap = (tr_side-tr_main)/2;
a = move([-tr_side/3.5,-tr_side/2],tr_side_gap,0);
b = move(a,tr_main,0);
c = move(b,tr_side_gap,60);
d = move(c,tr_main, 120);
e = move(d,tr_side_gap,180);
f = move(e,tr_main,240);
  
difference() {
    cylinder(h=cy_height,d1=cy_d,d2=cy_d, center=false);
    translate([0,0,sq_height/2]) cube([sq_size,sq_size,sq_height], center=true);
    translate([0,0,cy_height-tr_height])
        linear_extrude(height=tr_height+1)
            polygon([a,b,c,d,e,f],center=false);
}
