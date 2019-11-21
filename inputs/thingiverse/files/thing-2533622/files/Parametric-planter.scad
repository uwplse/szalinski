////////////   parametric pot   ///////////



//bracket radius
bracket_r=58.1;
//bracket heigh (including lip)
bracket_h=24;       //including lip
//bottom radius
insert_r_bot=41.75;
//how high is the insert
insert_h=108;
//(total_h= insert_h+bot_thick+drainage_h) prevents root rot
drainage_h=12;//[0:30]

//extra radius of lip (bracket r + lip = top r)
lip_dr=2;
//lip height
lip=1;
//radius tolerance (0=tight fit)
tol=1;//[0:5]

//wall thickness, recommend at least 4x extrusion width
wall=1.6;
//thickness of bottom wall
bot_thick=2;


//circle fragment angle (5, low value for best fit)
insert_fa=3;  
//low poly fan? this is your friend
sides=5;
twist=45;
//low poly fan? 0.01-low poly, 3-smooth(will take years to compile)
slice_factor=0.01;

//adds to bracket radius, will expand the top if lip is too long. default=0
inflation_dr=0;




////////////////////////////////////////////

all_h=insert_h+drainage_h+bot_thick;
r1=(insert_r_bot+tol);
r2=bracket_r+tol+.01+inflation_dr;
hi=((bot_thick+drainage_h)-((r1/r2)*(all_h-bracket_h)))/((r1/r2)-1);

l_r_top=(((hi+all_h)/(hi+all_h-bracket_h))*bracket_r);
l_r_bottom=(((hi+bot_thick+drainage_h)/(hi+all_h-bracket_h))*bracket_r);




///////////////////////////////////
difference(){
    difference(){
        shell(all_h,l_r_bottom+wall,l_r_top+wall,sides);
        difference(){
            shell(all_h,l_r_bottom,l_r_top,sides);
            cylinder(h=bot_thick,r=l_r_bottom*2);
            difference(){
                cylinder(h=all_h,r=2*l_r_top);
                cylinder(h=all_h,r=bracket_r,$fa=insert_fa);}
                }
        }
    translate([0,0,all_h-lip]) cylinder(h=lip,r=bracket_r+lip_dr,$fa=insert_fa);
}

///////////////////////////////////
module shell(h,r_bottom,r_top,n_sides){
    linear_extrude(height=h,scale=r_top/r_bottom,,twist=twist,slices=all_h*slice_factor)
        circle(r_bottom/cos(180/n_sides),$fn=n_sides);
}
