///Parameters///
//measurments in milimeters
//note: change width/length first, then adjust hole_spacing for each


width = 160;
length = 120;
thickness = 4;
height = 20;
underhang = 2;
hole_size = 10;
hole_spacing_x = 4;
hole_spacing_y = 5;

//code
module cooling_stand ()
{
    difference(){
        cube([width,length,height],center=true);
        cube([width-2*thickness,length-2*thickness,height+0.02],center=true);
     translate([0,0,height/2-.5*underhang+0.01])cube([width-thickness,length-thickness,underhang],center=true);
    }
}

module hole()
{
    rotate([90,0,0])scale([1,1.4,1])cylinder(h=thickness+0.01,d=hole_size,$fn=50,center=true);
}
module air_holes()
{
    //determines how many holes to make on x axis
    number_holes_x=round((width-2*thickness)/hole_size);
    for(i=[1:1:number_holes_x/2-1])
    {
        translate([-hole_size-hole_spacing_x+i*(hole_size+hole_spacing_x),-length/2+(thickness/2),0])hole();
    }
    for(j=[1:1:number_holes_x/2-2])
    {
        translate([-j*(hole_size+hole_spacing_x),-length/2+(thickness/2),0])hole();
    }
    
    mirror([0,1,0])
    {
        
    for(i=[1:1:number_holes_x/2-1])
    {
        translate([-hole_size-hole_spacing_x+i*(hole_size+hole_spacing_x),-length/2+(thickness/2),0])hole();
    }
    for(j=[1:1:number_holes_x/2-2])
    {
        translate([-j*(hole_size+hole_spacing_x),-length/2+(thickness/2),0])hole();
    }
    }
    
    //determine how many holes to make on y axis
    number_holes_y=round((length-2*thickness)/hole_size);
    for(k=[1:1:number_holes_y/2-1])
    {
        translate([width/2-thickness/2,hole_spacing_y+hole_size-k*(hole_size+hole_spacing_y),0])rotate([0,0,90])hole();
    }
    for(l=[1:1:number_holes_y/2-2])
    {
        translate([width/2-thickness/2,l*(hole_size+hole_spacing_y),0])rotate([0,0,90])hole();
    }
    mirror([1,0,0])
    {
        number_holes_y=round((length-2*thickness)/hole_size);
    for(k=[1:1:number_holes_y/2-1])
    {
        translate([width/2-thickness/2,hole_spacing_y+hole_size-k*(hole_size+hole_spacing_y),0])rotate([0,0,90])hole();
    }
    for(l=[1:1:number_holes_y/2-2])
    {
        translate([width/2-thickness/2,l*(hole_size+hole_spacing_y),0])rotate([0,0,90])hole();
    }
    }
    
 
    
}

module footpads()
{
    translate([-width/2+0.01,-length/2+0.01,-height/2])difference(){cylinder(h=2,d=20,$fn=50);
    translate([0,0,-1])cube([10,10,4]);}
    
    translate([width/2-0.01,length/2-0.01,-height/2])rotate([0,0,180])difference(){cylinder(h=2,d=20,$fn=50);
    translate([0,0,-1])cube([10,10,4]);}
    
    translate([width/2-0.01,-length/2+0.01,-height/2])rotate([0,0,90])difference(){cylinder(h=2,d=20,$fn=50);
    translate([0,0,-1])cube([10,10,4]);}
    
    translate([-width/2+0.01,length/2-0.01,-height/2])rotate([0,0,-90])difference(){cylinder(h=2,d=20,$fn=50);
    translate([0,0,-1])cube([10,10,4]);}
}

difference()
{
cooling_stand();
air_holes();
}
footpads();