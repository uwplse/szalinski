//Moto G phone case for FTC
//Alissa Jurisch
//11/16/2017
//rev 1

//FTC team number
Team = 12000; //your team number
//your team name
TeamName="SpLit"; //your team name
 //65 gives you just over the 2.5 inches necessary for rules
height = 6; //65 gives you just over the 2.5 inches necessary for rules


difference(){
cube([76.5,75,18]); //main box
    translate([3,3,3]) {
cube([70.5,97,12]); //subtracts phone
    }
    translate([9,3,6]){
cube([58.5,97,15]); //creates opening    
    }
    translate([20,-3,3]){
        cube([36.5,12,10]);
    }

translate ([5,30,15]){
linear_extrude(3) {
        rotate(270,0,0){
		text(str(Team),size=height, font="Ariel:Bold", halign = "center", valign = "center", spacing = 2);
                }
        }
    }

translate ([72,30,15]){
linear_extrude(3) {
        rotate(270,0,0){
		text(str(TeamName),size=height, font="Ariel:Bold", halign = "center", valign = "center", spacing = 2);
            }
        }   
    }
}

