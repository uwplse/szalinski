


use <write/Write.scad>
use <Write.scad>

// preview[view:south, tilt:top]

/* [global] */
//Width of the square. Small: 15mm / Medium: 20mm / Large: 30mm
size = 30; // [15:Small,20:Medium,30:Large]



//For initials, designed for one letter only. 
left_initial = "A"; 
right_initial = "M"; 

//Select font. 
your_font = "write/Letters.dxf"; // ["write/Letters.dxf":Letters,"write/orbitron.dxf":Orbitron,"write/knewave.dxf":Knewave,"write/BlackRose.dxf":Blackrose, "write/braille.dxf":Braille]


/* [hidden] */
w = size;
r = 5; 
w2 = .93*size;
r2 = .93*r; 
thickness = 2.5;
$fn=150; 

lx = w/2;
ly = w/2;
diag = w; 
c2x=.85*lx;
c2y=.60*w;
c3x=1.15*lx; 
c3y=.40*w; 


module base() {
translate([r,r,0]) circle(r); 
translate([r,(w-r),0]) circle(r); 
translate([(w-r),r,0]) circle(r);
translate([(w-r),(w-r),0]) circle(r); 
translate([r,0,0]) square([(w-2*r),(w)]); 
translate([0,r,0]) square([(w),(w-2*r)]); 
}

module innerBase() {
translate([r2,r2,0]) circle(r2); 
translate([r2,(w2-r2),0]) circle(r2); 
translate([(w2-r2),r2,0]) circle(r2);
translate([(w2-r2),(w2-r2),0]) circle(r2); 
translate([r2,0,0]) square([(w2-2*r2),(w2)]); 
translate([0,r2,0]) square([(w2),(w2-2*r2)]); 
}


module jaggedLine() {
linear_extrude(height = thickness+10, center = true) polygon( [ [(lx-.2),(w+2)],[(lx-.2),(.75*w)],[c2x,c2y],[c3x,c3y],[(lx-.2),(.20*w)],[(lx-.2),(-2)],[(lx+.2),(-2)],[(lx+.2),(.20*w)],[(c3x+.4),(c3y)],[(c2x+.4),(c2y)],[(lx+.2),(.75*w)],[(lx+.2),(w+2)] ] , [ [0,1,2,3,4,5,6,7,8,9,10,11] ]); 
}

module rightSquare() {
polygon( [ [(lx),(1.2*diag)],[(lx),(.75*diag)],[c2x,c2y],[c3x,c3y],[(lx),(.30*diag)],[(lx),(-2)],[(2.5*lx),(-2)],[(2.5*lx),(1.2*diag)] ] , [ [0,1,2,3,4,5,6,7,8] ]); 
}

module leftSquare() {
polygon( [ [(lx),(1.2*diag)],[(lx),(.75*diag)],[c2x,c2y],[c3x,c3y],[(lx),(.30*diag)],[(lx),(-2)],[(-20),(-2)],[(-20),(1.2*diag)] ] , [ [0,1,2,3,4,5,6,7,8] ]); 
}

module leftSection() {
difference() {
base();
rightSquare(); 
}

}

module rightSection() {
difference() {
base();
leftSquare(); 
}

}





difference() {

linear_extrude(height = thickness) leftSection(); 
translate([(.035*w),(.035*w),1.5]) linear_extrude(height = thickness-1.10) innerBase(); 

}

difference() {

translate([5,0,0]) linear_extrude(height = thickness) rightSection(); 
translate([(.035*w)+5,(.035*w),1.5]) linear_extrude(height = thickness-1.10) innerBase(); 

}


if (w == 15) {

translate([(.10*w),(.28*w),1.49]) write(left_initial,t=.75,h=7,center=false, font=your_font); 
translate([(.63*w)+5,(.28*w),1.49]) write(right_initial,t=.75,h=7,center=false, font=your_font); 

} else if (w == 20) {

translate([(.10*w),(.28*w),1.49]) write(left_initial,t=1,h=9,center=false, font=your_font); 
translate([(.63*w)+5,(.28*w),1.49]) write(right_initial,t=1,h=9,center=false, font=your_font); 

} else if (w == 30) {

translate([(.10*w),(.3*w),1.49]) write(left_initial,t=1,h=13,center=false, font=your_font); 
translate([(.63*w)+5,(.3*w),1.49]) write(right_initial,t=1,h=13,center=false, font=your_font); 


}

difference() {
translate([(.25*w),(1.06*w),0]) cylinder((.5*thickness),3,3); 
translate([(.25*w),(1.06*w),-1]) cylinder((thickness),1.5,1.5); 

}

difference() {
translate([(.75*w)+5,(1.06*w),0]) cylinder((.5*thickness),3,3); 
translate([(.75*w)+5,(1.06*w),-1]) cylinder((thickness),1.5,1.5); 

}
