include <configuration.scad>

axis_dia = 8;
bearing_od=13;
bearing_id=4;
bearing_h=5;


module BallScrewBase() {
    height=13;
    clamp_width = 20;
    clamp_length = 27;
    clamp_split = 1.5;
    mount_dia = 38;
    tension_distance = 1;
    
    thread_angle = 5;
    
    difference() {
        union() {
            // body
            cylinder(d=mount_dia, h=height);
            // clamp
            translate([-clamp_width/2,0,0])cube(size=[clamp_width, clamp_length, height]);
        }
        // Split
        translate([-clamp_split/2,0,0])cube(size=[clamp_split, clamp_length, height]);
        // Space for axis
        cylinder(d=axis_dia*1.6, h=height);
        for (a=[60:120:360]) {
            // screw holes
            rotate([0,thread_angle,a])translate([0,(axis_dia + bearing_od)/2 - tension_distance, -m4_dia ])cylinder(d=m4_dia, h=height*2);
            // bearing holes
            rotate([0,thread_angle,a])translate([0,(axis_dia + bearing_od)/2 - tension_distance, -bearing_h+1 ])cylinder(d=bearing_od + 2, h=bearing_h);
            
        }
        
    }
        
}

BallScrewBase();