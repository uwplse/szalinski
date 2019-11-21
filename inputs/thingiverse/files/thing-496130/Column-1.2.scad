//Customizable Column v1.2
//v1.2 Customizer fix, added ionic capital
//v1.0 had 10 downloads
//v1.1 had 381 downloads
//Created by Ari M. Diacou, October 2014
//Shared under Creative Commons License: Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0) 
//see http://creativecommons.org/licenses/by-sa/3.0/


//The ratio of the height to the width of the column
ratio=5;
//The length of the column including the base and capital
height=20;
//Stripes that go up the column
fluting="roman";//[roman,greek,none]
capital="ionic";//[corinthian,simple,ionic]


						/*[Hidden]*/
///////////////// Variables //////////////////////////
pi=3.1415+0;
ep=0.001+0;
width=height/ratio;
capital_height=(capital=="corinthian")
				  ? width*1.3 
				  : width*0.25;
//types=["tuscan","doric","ionic","corinthian"]+0;
//chosen_type="tuscan";//["tuscan","doric","ionic","corinthian"]+0;
//x=search(chosen_type,types)+0;
//echo(x);

////////////////// Main() ///////////////////////////
column();
//////////////// Functions ////////////////////////////
module column(){
	bottom();
	top();
	shaft();
	}

module top(){
	translate([0,0,height-ep]){
        if(capital=="corinthian"){
            corinthian_capital();}
        if(capital=="ionic"){
            ionic_capital();}
        if(capital=="simple"){
            cube([width*1.25,width*1.25,width*0.25],center=true);}
        }
	}

module bottom(){
	translate([0,0,width*0.125]) 
		cube([width*1.25,width*1.25,width*0.25],center=true);
	}

module shaft(){
	difference(){
		cylinder(h=height, r=width/2,$fn=72);
		if(fluting=="greek" || fluting=="roman"){
			for(i=[0:23]){
				translate((width/2)*[sin((360/24)*i),cos((360/24)*i),0])
					cylinder(h=height, 
								r=(fluting=="greek")? (pi*width/2/24):(pi*width/2/36),
								$fn=24);
				}
			}
		}
	}

module ionic_capital(){
    x=width*0.5+capital_height;
    y=width*.625;
    z=-0.5*capital_height;
    cube([width+2*capital_height,width*1.25,capital_height],center=true);
    translate([x,y,z])
        rotate([90,0,0])
            cylinder(h=width*1.25,d=capital_height*2,$fn=12);
    translate([-x,y,z])
        rotate([90,0,0])
            cylinder(h=width*1.25,d=capital_height*2,$fn=12);
    }
module corinthian_capital(){
    z=capital_height;
	ep=.001;
	resize([1.2*z,1.2*z,z])
	translate([0,0,-4])
	union(){
		difference(){
			for(i=[1:12]){
				rotate([0,0,(i+0.0)*30]) petal(3);
				rotate([0,0,(i+0.5)*45]) petal2(3);
				rotate([0,0,(i+0.5)*90]) petal3(3);
				}
			cube([16,16,8],center=true);
			}
		translate([0,0,7+6+.5-ep]) cube([12,12,1],center=true);
		}
	}
module petal(x){
	translate([0,-x,0])
	linear_extrude(height = 7, center = false, convexity = 10, scale=[1,2], $fn=24)
		translate([0, x, 0])
			circle(r = 1.5);
	}

module petal2(x){
	translate([0,-x,3])
	linear_extrude(height = 7, center = false, convexity = 10, scale=[1,2], $fn=24)
		translate([0, x, 0])
			circle(r = 1.5);
	}

module petal3(x){
	translate([0,-x,6])
	linear_extrude(height = 7, center = false, convexity = 10, scale=[1,1.98], $fn=24)
		translate([0, x, 0])
			circle(r = 2.5);
	}