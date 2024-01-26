// Number of parts
num_parts = 16;
// Number of columns
max_columns = 4;
// Horn Height
h_height = 100;
// Horn Radius 
radius = 25;
// Horn Shape - 0 - circle, 3 - triangle, 5 - pentagon, 6 - hexagon
faces = 6;
/* [Advanced] */
// Resolution - Bigger the number, the longer it takes to render
resolution = 100;
// Part to show - Use this to only show that specific part, useful for exporting, see batch export script, leave as 0 to show all
part = 0;

/* [Hidden] */
// Default Viewport/camera settings - comment out to stop Viewport/camera moving or edit them to your liking, current viewport settings can be seen at bottom left
$vpt = [150.51, 3.33, 102.94];
$vpr = [55.70, 0, 20.80];
$vpd = 755.18;
$vpf = 22.50;

X = radius*1.729; 
Y = radius*1.5; 

for(i=[0:num_parts-1]) { 
    if(part == i + 1 || part == 0){
        column = i % max_columns; 
        row = floor(i / max_columns);
        //echo("column=",column," row=",row);
        //twist = 5 * i; // Twist based of which part it is, can get a bit crazy with a large number of parts, so exploring other ideas as seen below
        twist = rands(25,235, 1)[0]; // Random number twist value, giving better results
        //twist = 235; // Test value to see how a twist looks
        echo(twist);
        colP = (row % 2 != 0) ? (radius/2)*1.725:0;
        translate ([column*X + colP, row*Y, 0]) {
            rvect=rands(0,1,3);
            color([rvect[0],rvect[1],rvect[2]])// Random Color
            horn(h_height, radius, twist, faces, resolution);
        }
    }
}

module horn(height = 100, radius = 10, twist = 720, faces = 6, resolution) {   
    height = height - 10;
    radius = radius - 2;
    rotate([0,0,30]) // Base
        translate([0, 0, -10])
            linear_extrude(10)
                circle(r=radius + 2,$fn=6);
    //radius2 = radius/4;
	radius2 = radius;
	translate([-radius2,0]) // De-translate.
	linear_extrude(height = height, twist = twist, scale=0, $fn = resolution) // Horn
        translate([radius2,0])
            rotate([0,0,30])
                circle(r=radius2,$fn=faces);
}