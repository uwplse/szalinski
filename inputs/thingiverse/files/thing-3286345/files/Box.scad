// Universal Box by Paxy

/*Customizer Variables*/
height=31;//[5:1:100]
width=58;//[5:1:100]
depth=18;//[5:1:100]
wall=1;//[0.5:0.2:5]
tollerance=1.2;//[0.5:0.2:5]

//redner box
render()base();

//reder cap
//try how it close the base
//translate([0,-wall,depth-wall]) render() cover(); 
translate([-20,0,2*wall+wall*tollerance]) rotate([180,0,180]) render() cover();

/* modules */

module base()
{
difference()
{
   union()
    {
        cube([height+2*wall,width+2*wall,depth+wall]);
        translate([-wall,-wall,depth]) cube([height+4*wall,width+4*wall,wall]);
    }    
    translate([wall,wall,wall])cube([height,width,depth]);
    
    // place for holes
    
    
}
}

module cover(){
    difference()
    {
        translate([-wall*tollerance-wall,-wall,0]) cube([height+4*wall+2*tollerance*wall,width+5*wall+tollerance*wall,2*wall+wall*tollerance]);
        translate([-wall*tollerance,-wall,wall]) cube([height+2*wall+2*tollerance*wall,width+4*wall+tollerance*wall,tollerance*wall]);
        
        translate([-(tollerance-wall)/2,-wall,0]) cube([height+wall+wall*tollerance,width+4*wall,wall]);
    }
    
}