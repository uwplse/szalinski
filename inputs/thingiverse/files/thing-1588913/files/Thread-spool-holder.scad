//fillet radius
fillet_radius = 10;
//base thickness 
base_thickness = 3;
//diameter holder
diameter_holder = 10;
//cell distance
cell_distance = 45;
//total height
total_height = 70;
//rows
iRows = 4;
//cols
iColumns = 3;

module spitze(rr,tb,ds,delta,hh){
        
union(){
    difference()
    {
        rotate([0,0,30]) cylinder(h = hh/2, d=delta/(2*cos(30))*2+0.001, $fn = 6);
        rotate_extrude(convexity = 10, $fn = 12) hull()
        {
            translate([ds/2+rr-.2, rr+tb, 0]) circle(r = rr, $fn = 60);
            translate([ds/2+rr-.2, hh, 0]) circle(r = rr, $fn = 60);
            translate([delta, rr+tb, 0]) circle(r = rr, $fn = 60);
            translate([delta, hh, 0]) circle(r = rr, $fn = 60);            
        }
    }
    hull(){
        translate([0,0,hh/2-0.01]) sphere(d=ds, $fn = 12);
        translate([0,0,5/7*hh]) sphere(d=ds, $fn = 12);
        translate([0,0,hh-ds/4]) sphere(d=ds/2, $fn = 12);
    }
}
}


union(){
for (i=[0:iRows-1]){ //6
    for (j=[0:iColumns-1]){ //6
        
        if(round(j/2)*2==j){
			translate ([0+45*i,   j*sin(60)*45,0]) spitze(fillet_radius,base_thickness,diameter_holder,cell_distance,total_height);
		}
        else 
        {
			translate ([45/2+45*i,   j*sin(60)*45,0]) spitze(fillet_radius,base_thickness,diameter_holder,cell_distance,total_height);
		}
    }
}
}

