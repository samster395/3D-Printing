// Part = 0 draws everything at once
// Any other number draws a section that's exported as one object
part = 0; 

$fn = 40;

// Reposition everything to the level of the floor.
translate([0, 0, 2.5]){

    // Body
    if(part == 1 || part == 0){
        // These two items are exported as one object.
        cube([5, 5, 5], center = true);
        cube([12, 1, 1], center = true);
    }
     
    // Head
    if(part == 2 || part == 0){
        translate([0, 0, 5]) sphere(d = 5);
    }
     

}