$fn=60;
h_height=30;
hc_height=10;
h_size = 30;
t = 2;
support_r=3;
support_h=3;
planter = 1;

module flat_heart( h, s) {
  square(s);

  translate([s/2, s, 0])
  circle(s/2);

  translate([s, s/2, 0])
  circle(s/2);
}

module heart( h, s){
    difference()
    {
        linear_extrude(height=h) flat_heart( h, s);
        linear_extrude(height=h-t) translate( [ t/2, t/2, 0]) flat_heart( h-t, s-t);
    }
}

module cover( with_feet){
    // cover
    union(){
    rotate([180, 0, 90]) translate( [-t, -t, -hc_height]) heart( hc_height, h_size+t*2);
    if ( with_feet == 1){
        // feets
        translate([h_size/2, h_size/4, -2+support_h]) cylinder( r=support_r, h=support_h);
        translate([h_size, h_size/4, -2+support_h]) cylinder( r=support_r, h=support_h);
        rotate([0, 0, 90]){
            translate([h_size/2, -h_size/4, -2+support_h]) cylinder( r=support_r, h=support_h);
            translate([h_size, -h_size/4, -2+support_h]) cylinder( r=support_r, h=support_h);
        }
        rotate([0, 0, 20]) translate([h_size, h_size/2, -2+support_h]) cylinder( r=support_r, h=support_h);
        }
    }
}
module heart_planter( with_planter){
    difference(){
        heart( h_height, h_size);
        if ( with_planter == 1)
            translate([h_size/2, h_size/2, -2+support_h]) cylinder( r=3, h=100);    
    }
}

heart_planter( planter);
//cover( planter);