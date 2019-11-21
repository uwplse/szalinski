corner_angle = 90;
radius = 10; 

//edge length
e = 80;//[50:150]
//height of base plate
h = 8; //[5:15]
// fence height
dz = 8; // [1:20]
//fence length
cl = 25; //[10:50]
//fence thickness
cw = 8; //[1:15]
//dimension of dust groove
cc = 1;   //[0:0.2:2]
//grabber diameter
d_grabber = 25; //[0:50]
//grabber offset
grabber_off = 0; //[-30:30]


////// internal values ///////
a = e - radius;
alpha = corner_angle/2;
beta = 90-alpha;
mx = radius/sin(alpha);
my = 0+0;
br = e+0;
grbpos = br/2+grabber_off;

//debugging stuff
/*
color([0,0,0])translate([mx,my,0])cylinder(r=0.3,h=50);
color([0,0,0])translate([mx,0,h])rotate([0,0,corner_angle/2])cube([.4,100,.2],center=true);
color([0,0,0])translate([mx,0,h])rotate([0,0,-corner_angle/2])cube([.4,100,.2],center=true);
*/

difference(){
    intersection() {
        union(){
            hull(){
                translate([mx,my,0])
                    #cylinder(r=radius,h=h,$fn=radius*20);
                
                //outer straight edges
                //translate([mx-cos(beta)*radius,-sin(beta)*radius,0])
                    rotate([0,0,-alpha])
                    //translate([0,0,0])
                    translate([br,0,0])
                    cube([2*a,1,h]);
                //translate([mx-cos(beta)*radius,sin(beta)*radius,0])
                    rotate([0,0,alpha])
                    translate([br,-1,0])
                    cube([2*a,1,h]);
                //for the shape
                translate([mx,-0.5,0])
                    cube([2*a,1,h]);
            }
            //fences
            rotate([0,0,-alpha])
                translate([br-cl,0,0])
                mirror([0,1,0])
                fence();
            rotate([0,0,alpha])
                translate([br-cl,0,0])
                fence();
            
        }
        //outer boundary
        cylinder(r=br,h=h+dz,$fn=4*br);
    }
    
    //grabber
    translate([grbpos,0,0])
        cylinder(r=d_grabber/2,h=h);
    
    //dust grooves
    rotate([0,0,-alpha])
        translate([br-cl/2,0,h])
        rotate([45,0,0])
        cube([cl+0.1,cc,cc],center=true);
    rotate([0,0,alpha])
        translate([br-cl/2,0,h])
        rotate([45,0,0])
        cube([cl+0.1,cc,cc],center=true);
    
    
    //text
    translate([grbpos+d_grabber/2+5,0,0])rotate([0,0,90])
        mirror()
        linear_extrude(height=2)
        text(str(radius), font = "Liberation Sans",valign="top",halign="center",size=10);

    //letter width
    lw = 0.7*h*0.814;
    //angle of single letter
    la = 2*asin(lw/(2*br));
    ll = len(str(radius));
    rotate([0,0,ll/2*la-la/2])
    for(i=[0:1:ll-1]) {
        rotate([0,0,-la*i])
        translate([br,0,h/2])
        rotate([0,-90,0])
        rotate([0,0,90])
        mirror()
        linear_extrude(height=2)
        #text(str(radius)[i], font = "Monospace",halign="center", valign="center",size=0.7*h);
    }
    
}

module fence(){
    difference(){
        union(){
            cube([cl,cw,h+dz]);
            translate([0,-2,0])cube([cl,cw+2,h]);
        }
        translate([cl/2,0,h+dz])
            rotate([45,0,0])
            cube([cl,1,1],center=true);
        
        translate([0,0,h+dz/2])
            rotate([0,0,45])
            cube([1,1,dz],center=true);
        
        translate([cl,0,h+dz/2])
            rotate([0,0,45])
            cube([1,1,dz],center=true);
    }
}