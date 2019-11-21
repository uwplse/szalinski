//Constructs a plug for rectangle-shaped pipes. 
//By Simon Klein

//Outer thickness of the bottom part
bd=3;   
//Outer tube width (=Bottom width)
bw=56;  
//Outer tube height (=Bottom height)
bh=35;  
//Outer radius of the tube edges 
br=3;   
//Total depth
d=20;   
//Wall-thickness
b=0.8;  
//Depth of the lamella
lb=2;   
//Width of the base of the lamella
ld=2.5; 
//Width of the top of the lamella
lf=0.5; 
//Number of lamella
lx=3;   
//Distance of lamella
ll=4;   
//Offset from the bottom
lo=8;   

//wall thickness of pipe (Difference between width of the bottom and the lamella)
ws = 2.5; 

//Inner chamfer on the bottom
bc=1.5; 
//Inner bottom wall thickness
bws=2;  

//Number of facets on round edges
$fn=32; 

w=bw-2*ws-lb;
h=bh-2*ws-lb;
lr=max(0,br-ws/2);
r=max(0,br-ws/2-lb);

difference() {
    union() {
        rCube2D([w,h,d],r);
        translate([0,0,-d/2+bd/2])
            rCube2D([bw,bh,bd],br);
        translate([0,0,-d/2+lo])
            for (i = [1:lx]) {
                translate([0,0,(i-1)*ll])
                    lamella(w,h,lr,lb,ld,lf);
            }
    }
    translate([0,0,bws])
        chamfer([w-2*b,h-2*b,d],max(0,r-b),bc);
}

module lamella(w,h,r,lb,ld,lf) {
    hull() {
        rCube2D([w+2*lb,h+2*lb,lf],max(r,0));
        translate([0,0,ld/2])
            rCube2D([w,h,0.001],max(r-lb,0));
        translate([0,0,-ld/2])
            rCube2D([w,h,0.001],max(r-lb,0));
    }
}

module chamfer(dim,r,bc) {
    translate([0,0,bc])
        hull() {
            translate([0,0,bc])
                rCube2D(dim,max(0,r-b));
            resize([dim[0]-2*bc,dim[1]-2*bc,dim[2]])
                rCube2D(dim,max(0,r-b));
        }
}

module rCube2D(dim, r) {
	if (r>0) {
		minkowski() {
				cube([dim[0]-2*r,dim[1]-2*r,dim[2]/2], center=true);
				cylinder(r=r,h=dim[2]/2, center=true);
		}
	} else {
		cube(dim,center=true);
	}
}