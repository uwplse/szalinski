/*

Space invaders Fleet


*/
// preview[view:south, tilt:top]
// As a random generator, every seeds creates a different scene
seed = 123;
// Which one would you like to see?
part = "both"; // [invader:Invader,base:Base,both:Invader and Base]

// Fleet's rows
Fleet_Rows = 2; // [1:10]
// Fleet's columns
Fleet_Columns = 3; // [1:10]

// Size in number of pixels
Invader_Width = 9;  // [3:30]
// Size in number of pixels
Invader_Height = 7; // [3:30]

// Separate the 'bases' when creating a fleet??
Separated_Bases = "No"; //[Yes:Yes.Every invader with his own base, No:NO.One base for all fleet.]

/* [Hidden] */
//seed = floor(rands(1,100000,1)[0]);
//echo(seed);
randoms = rands(0,1,10000,seed);


p = 0.6;
grid = 5;


//flota(1,1);
fx = Fleet_Columns;
fy = Fleet_Rows;
invx = Invader_Width;
invy = Invader_Height;


print_part();

module print_part() {
	if (part == "invader") {
        translate([-fx*0.5*(invx+2) * grid,-fy*0.5*(invy+2) * grid,0])
    		flota(fx,fy);
	} else if (part == "base") {
        translate([-fx*0.5*(invx+2) * grid,-fy*0.5*(invy+2) * grid,0])
    		flotabase(fx,fy);
	} else if (part == "both") {
        if(fy>fx){
            translate([0,-fy*0.5*(invy+2) * grid,0]){
    		    translate([-fx*(invx+2) * grid,0,0]) flota(fx,fy);
        		flotabase(fx,fy);
            }
        }else{
            translate([-fx*0.5*(invx+2) * grid,0,0]){
		        translate([0,-fy*(invy+2) * grid,0]) flota(fx,fy);
    		    flotabase(fx,fy);
            }
        }
	} else {
		translate([-fx*(invx+2) * grid,0,0]) flota(fx,fy);
		flotabase(fx,fy);
	}
}

module flota(sx,sy){
    ix = invx;
    iy = invy;
    for(i=[0:sx-1]){
        for(j=[0:sy-1]){
            translate([(ix+2)*i*grid,(iy+2)*j*grid,0])
            invader(ix,iy,rands(0,1,1000,seed+i*sx+j));
        }
    }
}
module flotabase(sx,sy){
    ix = invx;
    iy = invy;
    for(i=[0:sx-1]){
        for(j=[0:sy-1]){
            if(Separated_Bases=="Yes"){
                translate([(ix+3)*i*grid,(iy+3)*j*grid,0])
                base(ix,iy,rands(0,1,1000,seed+i*sx+j));
            }else{
                translate([(ix+2)*i*grid,(iy+2)*j*grid,0])
                base(ix,iy,rands(0,1,1000,seed+i*sx+j));
            }
        }
    }
}

module invader(sx,sy,rand){
    union(){
        for(i=[0:sx/2-(1-sx%2)]){
            for(j=[1:sy]){
                r = rand[i*sx+j];
                if(r<p){
                    color("Gold"){
                        translate([(1+i)*grid,j*grid,0]) cube([grid+0.001,grid+0.001,grid-1]);
                        translate([(sx-i)*grid,j*grid,0]) cube([grid+0.001,grid+0.001,grid-1]);
                    }
                }
            }
        }
    }
}

module base(sx,sy,rand){
    color("Aqua"){
        difference(){
            cube([(2+sx)*grid,(2+sy)*grid,5]);
            translate([0,0,1.001])
                invader(sx,sy,rand);
        }
    }
}