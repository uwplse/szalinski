length=100;
width=30;
front_angle=45;//[0:89]
wall=3;
jolly_boat_scale=0.4; //[0:0.01:0.49]
Cargo_Ship_Addon="Yes"; //[Yes, No]

/* [Hidden] */
fn=100;
eps=0.1;

complete_boat();
jolly_boat();
if (Cargo_Ship_Addon=="Yes")
{
    cargo();
}

module jolly_boat()
{
    //starboard
    translate([length/2,-width/4,0])
    scale(jolly_boat_scale)
    translate([-length/2,-width/2,0])
        complete_boat();
    
    //larboard
    translate([length/2,width+width/4,0])
    scale(jolly_boat_scale)
    translate([-length/2,-width/2,0])
        complete_boat();
    if (jolly_boat_scale<0.5)
    {
    //Bridge starboard
    translate([length/2-(length/2*jolly_boat_scale)/2,-width/4+width/2*jolly_boat_scale-jolly_boat_scale*wall+wall*jolly_boat_scale/2,-wall*jolly_boat_scale-eps])
    cube([length/2*jolly_boat_scale,width/4+jolly_boat_scale*(wall-width/2),wall*jolly_boat_scale]);
    
    //Brdige larboard
    translate([length/2-(length/2*jolly_boat_scale)/2,width-wall*jolly_boat_scale/2,-wall*jolly_boat_scale-eps])
    cube([length/2*jolly_boat_scale,width/4+jolly_boat_scale*(wall-width/2),wall*jolly_boat_scale]);
    }
}

module cargo()
{
cube([length/5,width,wall]);
translate([0,width/2-width*9/10/2,wall])
    cube([length/5,width*9/10,length/6]);
translate([0,0,length/6-wall])
cube([length/5,width,wall]);
}

module complete_boat()
{
difference()
{
boat();
 translate([wall,wall,eps])
    scale([(length-2*wall)/length,(width-2*wall)/width,(width/2-wall)/(width/2)])
boat();
}
}


module boat()
{
    difference()
{
    difference()
{
    rotate([0,90,0])
    translate([0,width/2,0])
    cylinder(h=length,r=width/2,center=false,$fn=fn);
    translate([-eps,-eps,0])
    cube([length+2*eps,width+2*eps,width/2],center=false);
}

difference()
{
translate([length-(sqrt(pow(width/2,2)+pow(width/2*tan(front_angle),2))+(width/2)/tan(front_angle))-eps,0,-width/2-eps])
cube([sqrt(pow(width/2,2)+pow(width/2*tan(front_angle),2))+(width/2)/tan(front_angle)+2*eps,width+2*eps,width/2+2*eps],center=false);
translate([length,width/2,0])
rotate([0,front_angle,0])
translate([-width/2,0,-(width/2*tan(front_angle)+sqrt(pow(width/2,2)+pow((width/2)/tan(front_angle),2)))-2*eps])
    {
cylinder(h=width/2*tan(front_angle)+sqrt(pow(width/2,2)+pow((width/2)/tan(front_angle),2))+4*eps,r=width/2,$fn=fn);
translate([-(width/2*tan(front_angle)+sqrt(pow(width/2,2)+pow((width/2)/tan(front_angle),2)))-2*eps,-width/2-eps,])
cube([(width/2*tan(front_angle)+sqrt(pow(width/2,2)+pow((width/2)/tan(front_angle),2)))-2*eps,width+4*eps,width/2*tan(front_angle)+sqrt(pow(width/2,2)+pow((width/2)/tan(front_angle),2))+4*eps]);
    }
}
}
}