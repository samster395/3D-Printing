// Number of parts
num_parts = 42;
// Number of columns
max_columns = 6;
// Min Hexagon Height
heightMin = 5;
// Max Hexagon Height
heightMax = 50;
// Hexagon Grid Max Width
hexWmax = 200;
// Mounting hole - Creates a hole at the back in the middle with a bigger hole inside to hang on a nail
hole = true;
// Hole Diameter
holeD = 4;
/* [Advanced] */
// Resolution - Bigger the number, the longer it takes to render
resolution = 100;
// Part to show - Use this to only show that specific part, useful for exporting, see batch export script, leave as 0 to show all
part = 0;
/* [Hidden] */
// Default Viewport/camera settings - comment out to stop Viewport/camera moving or edit them to your liking, current viewport settings can be seen at bottom left
//$vpt = [150.51, 3.33, 102.94];
//$vpr = [55.70, 0, 20.80];
//$vpd = 755.18;
//$vpf = 22.50;

$fn = resolution;
hexW3 = (hexWmax / (max_columns + .5)) / 0.8660254;
hexW = hexW3;
radius = hexW / 2; 
X = radius*1.729; 
Y = radius*1.5; 

difference(){
for(i=[0:num_parts-1]) { 
    if(part == i + 1 || part == 0){
        column = i % max_columns; 
        row = floor(i / max_columns);
        colP = (row % 2 != 0) ? (radius/2)*1.725:0;
        translate ([column*X + colP, row*Y, 0]) {
            rvect=rands(0,1,3);
            color([rvect[0],rvect[1],rvect[2]])// Random Color
            hex();
        }
    }
}
if(hole){
    translate([max_columns*(radius*0.75), 5, 0]){ // Hole
        cylinder(d=holeD, h=2);
        translate([0, 0, 2])
            cylinder(d=holeD*2, h=3);
    }
}
}

module hex() {  
    height = rands(heightMin,heightMax,1)[0];
    radius = radius - 2;
    rotate([0,0,30]) // Base
        translate([0, 0, 0])
            linear_extrude(height)
                circle(r=radius + 2,$fn=6);
}