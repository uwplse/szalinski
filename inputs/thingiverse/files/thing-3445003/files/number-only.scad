//use<roundCornersCube.scad>;
//Disable $fn and $fa, do not change these
//$fn=100;
//$fa=0.01;

//$fs=0.2;
//Numero para imprimir
num=5;


module number(num){
    if (num<10){
        echo("Menor que 10");
    translate([4, -5,2])linear_extrude(2)text(text=str("00",num));
    }
    else if (num<100){
        echo("Menor que 100");
    translate([4, -5,2])linear_extrude(2)text(text=str("0",num));
    }
    else{
       echo("Mayor que 100");
       translate([4, -5,2])linear_extrude(2)text(text=str(num));
    }
}

number(num); 
