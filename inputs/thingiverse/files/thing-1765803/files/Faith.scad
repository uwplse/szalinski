//CUSTOMIZER VARIABLES
 text = "openscad";
 text_size = 10;//  [6:20]
 //CUSTOMIZER VARIABLES END
 //use <C:\Windows\fonts\Starjedi.ttf>
 
union(){
    linear_extrude(height=1.5){
        difference(){
            square ([148,20],true);
            translate([-74,0]){
                circle (5);};
            translate([74,0]){
                circle (5);};
        }
    }
    linear_extrude(height=4.5){
        text(text = str(text), font = "star jedi", size = text_size, halign = "center", valign = "center");
    }
}