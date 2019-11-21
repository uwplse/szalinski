x=40;
y=40;
z=40;
r=4;
center=[-1,0,1];  //[x_axis, y_axis, z_axis] 0=center, 1=posative_side -1=negative_side
$fn=30;


//exanmple:
//squre_round(x,y,r,center);

//exanmple:
cube_round(x,y,z,r,center);


module cube_round(x,y,z,r,center){//width, height, radius
r_max   = x<=y ? (x<=z ? x/2 : z/2) : y/2;     //maximum possinle size of radeus
r_con   = r>0 && r<=r_max ? r :    //radius constrained
              r>r_max ? r_max : 0;

di       = r_con*2;               //diamitor of corner spheres 

echo(str(" Edge Radius .......................... = ", r_con));
echo(str(" Maximum Possible Edge Radius = ", r_max));

//rounds the number of fragments to a multiple of 4 so a vertex will always be at the top, bottom, right and left corners. This prevents slight misalignments of edges and inaccurat dimensions.

sm = $fn<4 ? 20 :  round($fn);
smooth=   sm   %4==0 ? sm   : 
         (sm+1)%4==0 ? sm+1 :
         (sm+2)%4==0 ? sm+2 : sm+3;


color([1,.5,.1])
translate([(center[0]==1 ? 0 : center[0]==-1 ? -x : -x/2) ,
           (center[1]==1 ? 0 : center[1]==-1 ? -y : -y/2) ,
           (center[2]==1 ? 0 : center[2]==-1 ? -z : -z/2)])

if(r<=0 || r==undef){       // without round corners
cube([x,y,z]);
}
else{                       // with round corners
//corners
corner(rot=  0, move=[x-r_con, y-r_con, 0]);//top r
corner(rot= 90, move=[  r_con, y-r_con, 0]);//top l
corner(rot=180, move=[  r_con,   r_con, 0]);//bottom l
corner(rot=-90, move=[x-r_con,   r_con, 0]);//bottom r

//edges
side(lenth=x-di, rot= 90, move=[  r_con, y-r_con, 0]);//top x
side(lenth=x-di, rot=-90, move=[x-r_con,   r_con, 0]);//bottom x
side(lenth=y-di, rot=  0, move=[x-r_con, y-r_con, 0]);//bottom y
side(lenth=y-di, rot=180, move=[  r_con,   r_con, 0]);//bottom y

//inside
translate([r_con, r_con, 0])
cube([x-di, y-di, z]);
}


module corner(rot,move){
translate(move)
rotate([0,0,rot])
rotate_extrude(angle=90, $fn=smooth)
edge_round();
}

module side(lenth,rot,move){
translate(move)
rotate([90,0,rot])
linear_extrude(lenth)
edge_round();
}

module edge_round(){
intersection(){
    square([r_con,z]);  
        hull(){
            translate([0,r_con,0]){
            translate([0,z-di,0])circle(r_con, $fn=smooth);//top  
            rotate([0,0,90])
            circle(r_con, $fn=smooth);//bottom  
            }
        }
    }
}
}



//****************************
module squre_round(x,y,r,center){//width, height, radius
r_max   = x<=y ? x/2 : h/2;     //maximum possinle size of radeus
r_con   = r>0 && r<=r_max ? r :    //radius constrained
          r>r_max ? r_max : 0;
di       = r_con*2;
//rounds the number of fragments to a multiple of 4 so a vertex will always be at the top, bottom, right and left corners. This prevents slight misalignments of edges and inaccurat dimensions.
sm = $fn<4 ? 20 :  round($fn);
smooth=  sm   %4==0 ? sm   : 
        (sm+1)%4==0 ? sm+1 :
        (sm+2)%4==0 ? sm+2 : sm+3;

color([1,.5,.1])
translate([(center[0]==1 ? 0 : center[0]==-1 ? -x : -x/2) ,
           (center[1]==1 ? 0 : center[1]==-1 ? -y : -y/2)])

if(r<=0 || r==undef){       // without round corners
square([x,y]);
}
else
translate([r_con,r_con,0])  // with round corners
hull(){
    translate([x-di, y-di, 0])circle(r_con, $fn=smooth);//top right 
    translate([0   , y-di, 0])circle(r_con, $fn=smooth);//top left 
    translate([x-di, 0   , 0])circle(r_con, $fn=smooth);//bottom right 
                              circle(r_con, $fn=smooth);//bottom left 
    }
}


