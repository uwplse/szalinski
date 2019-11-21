//Width of Shelf
shelfwidth=19.2;

//Clip Thickness
thickness=5;

//MainBodyWidth
mbwidth=8;

//Top support clip length
topcliplength=75;

//Clip Thickness
thickness=5;

//Bottom support clip length
bottomcliplength=100;

//Lower Support Thickness
lsupport=8;

//Upper Support Thickness
usupport=6;

//Clip Parameters
mouthwidth=3.5;

difference(){
union(){ //Combines all Parts    
    
//Render Light WireHolder Opening
linear_extrude (height=thickness)
polygon(points=[
        [mbwidth,-lsupport],
        [mbwidth,shelfwidth+usupport],
        [mbwidth+15,usupport+shelfwidth],
        [(mbwidth+11),-lsupport+10],
        [mbwidth+11,-lsupport],
	    ]);

//Top Clip
linear_extrude (height=thickness)
polygon(points=[
        [mbwidth,shelfwidth],
        [-topcliplength,shelfwidth-.5],
        [-topcliplength,shelfwidth+2],
        [mbwidth,usupport+shelfwidth],
        //[mbwidth,shelfwidth*.267+shelfwidth],
	    ]);

//Bottom Clip
linear_extrude (height=thickness)
polygon(points=[
        [mbwidth,0],
        [-bottomcliplength,.5],
        [-bottomcliplength,-4],
        [mbwidth,-lsupport],		
        //[mbwidth,-shelfwidth*.421],		
	    ]);
//Render Main Body
cube([mbwidth,shelfwidth,thickness]);        
    }       
    
//creates opening for wire    
translate([9.5,1,-10]){
    linear_extrude (height=50)
    circle(mouthwidth, $fn=50);
    }
    
translate([9.5,6,-10]){
    linear_extrude (height=50)
    circle(mouthwidth, $fn=50);
    }
    
translate([10,11,-10]){
    linear_extrude (height=50)
    circle(mouthwidth, $fn=50);
    }    

translate([10.5,16,-10]){
    linear_extrude (height=50)
    circle(mouthwidth, $fn=50);
    }   

translate([11,21,-10]){
    linear_extrude (height=50)
    circle(mouthwidth, $fn=50);
    }   
    
translate([12,26,-10]){
    linear_extrude (height=50)
    circle(mouthwidth, $fn=50);
    }       
}
    