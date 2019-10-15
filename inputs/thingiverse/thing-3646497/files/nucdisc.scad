/* [Main Dimensions] */

// Hole Size
hole_size = 28;
// Disc Size
disc_radius = 78;
// Disc Thickness
Thickness = 1.2;
// Knob height (make smaller than thickness to remove)
knob_height = 5;
// Width between queen excluder bars
queen_excluder_width = 4.1;

/* [Hidden] */
width = queen_excluder_width+1.2;
dist = (disc_radius/2+hole_size/2)/(1+sqrt(2));

//echo(dist);
//echo(disc_radius/4);

module check(in)
{
    if(dist > in/4)
    {
        return(dist*4+2);
    }
    else
    {
        return(in);
    }
}

outside_rad = disc_radius; 
//disc_radius = check(disc_radius);

module spoke(Lengtht,widd=wid)
{
    cube([.8,Lengtht,Thickness],center=true);
    cube([1.2,Lengtht,Thickness-.6],center=true);
}

module spokes(lengt,wid=width)
{
    steps = floor(hole_size / wid);
    centerr = steps/2*wid;
    intersection()
    {
        for(j=[0:steps])
        {
            translate([j*wid-centerr,0,Thickness/2])
                spoke(lengt);
        }
        cylinder(r=hole_size/2,h=Thickness);
    }
}

module disc()
{
    
    difference()
    {
        cylinder(r=outside_rad/2,h=Thickness,$fn=120);
        for(i=[0:3])
        {
            if(i != 3)
                translate([cos(i*90)*dist,sin(i*90)*dist,0])
                    cylinder(r=hole_size/2,h=Thickness);
        }
        cylinder(r=1.9,h=Thickness,$fn=30);
    }
    difference()
    {
        cylinder(r=4+.8,h=Thickness*2);
        cylinder(r=4,h=Thickness*2);
    }

    for(i=[0:3])
    {
        if(i == 3)
            translate([cos(i*90)*dist,sin(i*90)*dist,0])
                cylinder(r=5,h=knob_height,$fn=30);
    }

    translate([dist,0,0])
        spokes(hole_size,width);

    translate([-dist,0,0])
        spokes(hole_size,3);
}

rotate(180,[0,0,1])
    disc();