$fn=40;
height=12;
//tends to break. should be a little bit stronger but might then be too stiff. 
strength=1;

//we start the for loop with 0 thus the resulting amount is one more.
amount=14;

difference()
{
    for(i=[0:1:amount])
    {
        translate([(5+2*strength+1.5)*i,0,0])halter();     
    }
    //Nailhole 1/4
    translate([(amount*(1/4))*(5+2*strength+1.5),10,height/2])rotate([90,0,0])cylinder(r=1.5/2,h=10);
    //Nailhole center
    translate([(amount/2)*(5+2*strength+1.5),10,height/2])rotate([90,0,0])cylinder(r=1.5/2,h=10);
    //Nailhole 3/4
    translate([(amount*(3/4))*(5+2*strength+1.5),10,height/2])rotate([90,0,0])cylinder(r=1.5/2,h=10);
}



difference()
{
    union(){
translate([-(2+5+2*strength+1.5+1),5/2,0])cube([2+1+5+2*strength+1.55,strength*2,height]);
translate([(amount)*(5+2*strength+1.5),5/2,0])cube([2+5+2*strength+1.55,strength*2,height]);
    }
    //Screwhole left
    translate([-2-6,10,height/2])rotate([90,0,0])cylinder(r=4/2,h=10);
    
    
    
    //Screwhole right
    translate([1+6+(amount)*(5+2*strength+1.5),10,height/2])rotate([90,0,0])cylinder(r=4/2,h=10);
}
module halter()
{
    difference()
    {
        union()
        {
            cylinder(r=5/2+strength,h=height);
            translate([-2.5-strength,5/2,0])cube([5+2*strength+1.55,strength*2,height]);
        }
        cylinder(r=5/2,h=height);
        rotate([0,0,15])translate([-(strength*2)/2,-9/2,0])cube([strength*2,10/2,height]);
    
        rotate([0,0,-15])translate([-(strength*2)/2,-9/2,0])cube([strength*2,10/2,height]);
    
    
    }
}


