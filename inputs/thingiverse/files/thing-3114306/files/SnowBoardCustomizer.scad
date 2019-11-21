/* [Settings] */

//name written in the middle
name = "Bic";

//word size (Default = 7)
word_font_size = 9;

//0 (empty), 1 (basic), or 2 (with round)
type = 0; // [0:empty,1:With pins,2:With Hole]

//0 (no) or 1 (yes)
leash = 1; // [0:yes, 1:no]

//It is the file name of your Snowbase file
snowbasefile = "Snowboard_without_cramps.stl";



word_x = -6;              //to adjust the word x placement (Default: -2)

//to adjust the word y placement (Default: -5)
word_y = 27; // [27:front, -5:middle]




module snow () {

    translate ([0,0,-7.2]) {
        import(snowbasefile);
        }
}


//Code


difference() {

union () {
if (type == 0) {
    
    snow();    

}




if (type != 0) {
union() {
    translate ([10,-6.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([20,-6.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([10,-12.5,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([20,-12.5,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([10,-18.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([20,-18.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
}
}

if (type == 1) {
    
    union () {
        
    snow();
    

    

    translate ([-10,-6.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([-20,-6.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([-10,-12.5,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([-20,-12.5,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([-10,-18.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }
    translate ([-20,-18.25,0.1]) {
    cylinder(r1=1.5, r2=1.5, h=3.9, center=false, $fn=100);
    }

}
}

if (type == 2) {
    
    difference() {
        
        snow();
        
    translate ([-24,-12.5,2.1]) {
        cylinder(r1=5, r2=5, h=1, center=false, $fn=100);
        }
    }
    
}

translate ([word_y,word_x,2.5]) {
    rotate ([0,0,-90]) {
    linear_extrude( height=3, twist=0, center=true){
        text(name, font = "Roboto", size = word_font_size*0.75);
    }
}
}

}


if (leash == 1) {
    translate ([-40,-12.5,0]) {
        cylinder(r1=2.5, r2=2.5, h=10, center=false, $fn=100);
    }
}

}