/*[Settings]*/
//Amount of SD-Card slots you want ?
Amount = 15; // [5:1:30]

/*[Extra]*/
// How do you want the sides ?
Sides = "Closed" ; // [Open,Closed,Halfway,Qaurter]

// do you want stackable boxes ?
StackableOnSide = "None" ; // [Left,Right,Both,None]

Device_Lenght = Amount*6+3;

difference () {
    translate ([0,0,0]) cube ([Device_Lenght,31,27]);
    translate ([-1,5,6]) cube ([Device_Lenght+1,21,27]);
    for (a =[3:6:Device_Lenght]){translate ([a,3,3]) cube ([3,25,32]);}
}

if (Sides == "Closed") {
    translate ([0,0,0]) cube ([3,31,27]);
    translate ([Device_Lenght-3,0,0]) cube ([3,31,27]);
}
if (Sides == "Qaurter") {
    translate ([0,0,0]) cube ([3,31,20]);
    translate ([Device_Lenght-3,0,0]) cube ([3,31,20]);
}
if (Sides == "Halfway") {
    translate ([0,0,0]) cube ([3,31,13]);
    translate ([Device_Lenght-3,0,0]) cube ([3,31,13]);
}

if (StackableOnSide == "Left") {
    difference () {
        translate ([0,31,0]) cube ([Device_Lenght,3,25]);
        for (a =[5:20:Device_Lenght]){translate ([a-0.10,31,0]) cube ([3.20,3,25]);}
    }
}
if (StackableOnSide == "Right") {
    for (a =[5:20:Device_Lenght]){translate ([a,-3,0]) cube ([3,3,25]);}    
}
if (StackableOnSide == "Both") {
    difference () {
        translate ([0,31,0]) cube ([Device_Lenght,3,25]);
        for (a =[5:20:Device_Lenght]){translate ([a-0.10,31,0]) cube ([3.20,3,25]);}
    }
    for (a =[5:20:Device_Lenght]){translate ([a,-3,0]) cube ([3,3,25]);}    
}