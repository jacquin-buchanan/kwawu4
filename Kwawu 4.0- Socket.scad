// The Kwawu 4.0 prosthetic Arm - Socket Version
// By Jacqun Buchanan
// Parametric 3-d printable prosthetic arm
//
// This design is licensed under the Creative Commons - Attribution - Share Alike license.

// The ISO thread code is by Trevor Moseley

// The Interpolation and path smoothing code is by Timothy Weber
// https://github.com/teejaydub/tjw-scad

// Choose Part
Part = "Cuff1"; // [Palm, Palm Top, Index Finger End, Index Finger Phalanx, Middle Finger End, Middle Finger Phalanx, Pinky Finger End, Pinky Finger Phalanx, Ring Finger End, Ring Finger Phalanx, Thumb End, Thumb Phalanx, Whippletree Primary, Whippletree Secondary, Pencil Holder Cover, Hinges, Palm Bolt, Upper Arm, Lower Arm, Cuff1, Cuff2, Cuff3, Cuff Leather Template, Elbow Bolt1, Elbow Bolt2, Cuff2 Hub, Grasp Latch Base, Grasp Latch Probe, Ratchet, Tensioner Probe, EA Tensioner Lever, EA Tensioner Hold, SA Tensioner Lever,SA Tensioner Hold, Wrist Button, Wrist Cover ]
//Left or Right Arm
LeftRight = "Right"; //[Right, Left]
//Wraps are made from leather or plastic
LeatherOrPlastic = "Leather"; //[Leather, Plastic]
// Across all four knuckles (mm)
HandWidth = 96; //[65:186]
// Elbow crease to wrist attachment (mm)
ArmLength = 271; //[141: 564]
// At what length to split between Upper and Lower arm pieces. Measured from elbow (mm)
ArmSplitLength = 135; //[10: 564]
// Circumferences(mm) of Forearm start at elbow creses seperate by 25mm
ForearmCircumferences1 = [272,268,265,261]; //[0:1:600]
ForearmCircumferences2 = [255,0,0,0]; //[0:1:600]
ForearmCircumferences3 = [0,0,0,0]; //[0:1:600]
// Circumference of Bicep (mm)
BicepCircumference = 294; //[160: 600]
// Padding Thickness
PaddingThickness = 2; //[0: 10]
// Include Pencil Holder
PencilHolder = "No"; // [Yes,No]
// Add Air Venting Holes In Upper Forearm
UpperVentingHoles = "None"; // [None,VentingHoles1,VentingHoles2,VentingHoles3]
// Add Air Venting Holes In Lower Forearm
LowerVentingHoles = "None"; // [None,VentingHoles1,VentingHoles2,VentingHoles3]

/* [Hidden] */
//,255,0,0,0,0,0
ForearmCircumferences = concat(ForearmCircumferences1,ForearmCircumferences2,ForearmCircumferences3);

// ISO metric bolt holding palm together (mm) 
PalmBoltDiameter = 6;//[4, 6, 8]
// Rivet or Chicago screw holding cuff (mm)
RivetShaftDiameter = 5; //[2.4, 2.8, 3.1, 4, 5, 6]
// Velcro strap width (mm)
StrapWidth = 25;//[10: 60]

SlotSize = 0.5;
SlotLength = 10;//length of the opening slot
SlotSpacing = 3;//spacing between slots
SlotWidth = 2.4;//width of slots 
//The thickness of the cuff
ShellThickness = 2;

//The thickness of the Arm
ArmShellThickness = 3;

// This is an amount added to the pencil cover length. 
// When this is zero the pencil cover is as tight as possible.
// Make it larger to fit around larger/thicker pencils
PencilCoverAddedLength = 4.0;

PI =  3.141592653589793238;
HandVersion = "V3.0";

HandScale = HandWidth / 96;
ForearmCircumferenceWPadding = ((ForearmCircumferences[0]/PI) + 2*PaddingThickness)*PI;
ForeArmCircumferenceScale = ForearmCircumferenceWPadding/291;
ElbowPartsScale = max(0.73, ForeArmCircumferenceScale);
ForearmDiameterWPadding = ForearmCircumferenceWPadding/PI;
BicepCircumferenceWPadding = ((BicepCircumference/PI) + 2*PaddingThickness)*PI;
BicepDiameterWPadding = BicepCircumferenceWPadding/PI;
CuffScale = BicepCircumferenceWPadding/270;
CuffLength = CuffScale * 90;
ArmLengthScale = ArmLength/271;


WristBoltDia = 18;

// Shared wrist center values used across palm/button/cover geometry.
WRIST_X = 2.513 * HandScale;
WRIST_Y = 14.753 * HandScale;
WRIST_Z_BASE = -(21.5 * HandScale);

// Shared transform to place vent hole imports onto the sculpted arm shell.
VENT_ROTATION = [0, 0, -110];
VENT_TRANSLATION = [-2.5 * ForeArmCircumferenceScale, -14.7 * ForeArmCircumferenceScale, -302 * ArmLengthScale];

$fn=30;

module mirror_for_left() {
    if (LeftRight == "Left") {
        mirror([1,0,0]) children();
    } else {
        children();
    }
}

module mirror_for_right() {
    if (LeftRight == "Right") {
        mirror([1,0,0]) children();
    } else {
        children();
    }
}

MIRROR_NONE = 0;
MIRROR_LEFT = 1;
MIRROR_RIGHT = 2;

PART_NAME = 0;
PART_HANDLER = 1;
PART_MIRROR = 2;
PART_ROTATION = 3;

H_CUFF1 = 0;
H_CUFF2 = 1;
H_CUFF3 = 2;
H_CUFF_LEATHER_TEMPLATE = 3;
H_ARM_UPPER = 4;
H_ARM_LOWER = 5;
H_RATCHET = 6;
H_TENSIONER_PROBE = 7;
H_SA_TENSIONER_LEVER = 8;
H_EA_TENSIONER_LEVER = 9;
H_EA_TENSIONER_HOLD = 10;
H_SA_TENSIONER_HOLD = 11;
H_CUFF2_HUB = 12;
H_GRASP_LATCH_BASE = 13;
H_GRASP_LATCH_PROBE = 14;
H_PALM_BOLT = 15;
H_PALM = 16;
H_WRIST_BUTTON = 17;
H_WRIST_COVER = 18;
H_PALM_TOP = 19;
H_INDEX_FINGER_END = 20;
H_INDEX_FINGER_PHALANX = 21;
H_MIDDLE_FINGER_END = 22;
H_MIDDLE_FINGER_PHALANX = 23;
H_PINKY_FINGER_END = 24;
H_PINKY_FINGER_PHALANX = 25;
H_RING_FINGER_END = 26;
H_RING_FINGER_PHALANX = 27;
H_THUMB_END = 28;
H_THUMB_PHALANX = 29;
H_WHIPPLETREE_PRIMARY = 30;
H_WHIPPLETREE_SECONDARY = 31;
H_PENCIL_HOLDER_COVER = 32;
H_HINGES = 33;

PART_SPECS = [
    ["Cuff1", H_CUFF1, MIRROR_LEFT, [0,0,0]],
    ["Cuff2", H_CUFF2, MIRROR_LEFT, [0,0,0]],
    ["Cuff3", H_CUFF3, MIRROR_LEFT, [0,0,0]],
    ["Cuff Leather Template", H_CUFF_LEATHER_TEMPLATE, MIRROR_LEFT, [0,0,0]],
    ["Upper Arm", H_ARM_UPPER, MIRROR_LEFT, [0,0,0]],
    ["Lower Arm", H_ARM_LOWER, MIRROR_LEFT, [0,0,0]],
    ["Ratchet", H_RATCHET, MIRROR_LEFT, [0,0,0]],
    ["Tensioner Probe", H_TENSIONER_PROBE, MIRROR_LEFT, [0,0,0]],
    // This part was modeled as left, so mirror for right.
    ["SA Tensioner Lever", H_SA_TENSIONER_LEVER, MIRROR_RIGHT, [0,0,0]],
    ["EA Tensioner Lever", H_EA_TENSIONER_LEVER, MIRROR_LEFT, [0,0,0]],
    ["EA Tensioner Hold", H_EA_TENSIONER_HOLD, MIRROR_LEFT, [0,0,0]],
    ["SA Tensioner Hold", H_SA_TENSIONER_HOLD, MIRROR_LEFT, [0,0,0]],
    ["Cuff2 Hub", H_CUFF2_HUB, MIRROR_LEFT, [0,0,0]],
    ["Grasp Latch Base", H_GRASP_LATCH_BASE, MIRROR_LEFT, [0,0,0]],
    ["Grasp Latch Probe", H_GRASP_LATCH_PROBE, MIRROR_LEFT, [0,0,0]],
    ["Palm Bolt", H_PALM_BOLT, MIRROR_LEFT, [180,0,0]],
    ["Palm", H_PALM, MIRROR_LEFT, [0,0,0]],
    // Rotate to orient for printing.
    ["Wrist Button", H_WRIST_BUTTON, MIRROR_LEFT, [180,0,0]],
    ["Wrist Cover", H_WRIST_COVER, MIRROR_NONE, [0,0,0]],
    // Rotate to orient for printing.
    ["Palm Top", H_PALM_TOP, MIRROR_LEFT, [90,7,0]],
    ["Index Finger End", H_INDEX_FINGER_END, MIRROR_LEFT, [0,0,0]],
    ["Index Finger Phalanx", H_INDEX_FINGER_PHALANX, MIRROR_LEFT, [0,0,0]],
    ["Middle Finger End", H_MIDDLE_FINGER_END, MIRROR_LEFT, [0,0,0]],
    ["Middle Finger Phalanx", H_MIDDLE_FINGER_PHALANX, MIRROR_LEFT, [0,0,0]],
    ["Pinky Finger End", H_PINKY_FINGER_END, MIRROR_LEFT, [0,0,0]],
    ["Pinky Finger Phalanx", H_PINKY_FINGER_PHALANX, MIRROR_LEFT, [0,0,0]],
    ["Ring Finger End", H_RING_FINGER_END, MIRROR_LEFT, [0,0,0]],
    ["Ring Finger Phalanx", H_RING_FINGER_PHALANX, MIRROR_LEFT, [0,0,0]],
    ["Thumb End", H_THUMB_END, MIRROR_LEFT, [0,0,0]],
    ["Thumb Phalanx", H_THUMB_PHALANX, MIRROR_LEFT, [0,0,0]],
    ["Whippletree Primary", H_WHIPPLETREE_PRIMARY, MIRROR_LEFT, [180,0,0]],
    ["Whippletree Secondary", H_WHIPPLETREE_SECONDARY, MIRROR_LEFT, [0,0,0]],
    ["Pencil Holder Cover", H_PENCIL_HOLDER_COVER, MIRROR_NONE, [0,0,0]],
    ["Hinges", H_HINGES, MIRROR_NONE, [0,0,0]]
];

function find_part_index(part_name) =
    let(matches = search([part_name], [for (spec = PART_SPECS) spec[PART_NAME]]))
    len(matches) > 0 ? matches[0] : -1;

module apply_mirror(mirror_mode) {
    if (mirror_mode == MIRROR_LEFT) {
        mirror_for_left() children();
    } else if (mirror_mode == MIRROR_RIGHT) {
        mirror_for_right() children();
    } else {
        children();
    }
}

module apply_venting_transform() {
    rotate(VENT_ROTATION)
        translate(VENT_TRANSLATION)
            mirror([0,0,1])
                children();
}

module render_upper_venting() {
    if(UpperVentingHoles == "VentingHoles1") {
        VentingHoles12();
    }

    if(UpperVentingHoles == "VentingHoles2") {
        VentingHoles22();
    }

    if(UpperVentingHoles == "VentingHoles3") {
        VentingHoles32();
    }
}

module render_lower_venting() {
    if(LowerVentingHoles == "VentingHoles1") {
        VentingHoles11();
    }

    if(LowerVentingHoles == "VentingHoles2") {
        VentingHoles21();
    }

    if(LowerVentingHoles == "VentingHoles3") {
        VentingHoles31();
    }
}

module run_part_handlers() {
    MakeCuff1();
    MakeCuff2();
    MakeCuff3();
    MakeCuffLeatherTemplate();
    MakeArmUpper();
    MakeArmLower();
    MakeRatchet();
    MakeTensionerProbe();
    MakeSATensionerLever();
    MakeEATensionerLever();
    MakeEATensionerHold();
    MakeSATensionerHold();
    MakeCuff2Hub();
    MakeGraspLatchBase();
    MakeLatchProbe();
    MakePalmBolt();
    MakePalm();
    MakeWristButton();
    MakeWristCover();
    MakePalmTop();
    IndexFingerEnd();
    IndexFingerPhalanx();
    MiddleFingerEnd();
    MiddleFingerPhalanx();
    PinkyFingerEnd();
    PinkyFingerPhalanx();
    RingFingerEnd();
    RingFingerPhalanx();
    ThumbEnd();
    ThumbPhalanx();
    WhippleTreePrimary();
    WhippleTreeSecondary();
    PencilHolderCover();
    MakeHinges();
}

module run_part_handler(handler_index) {
    if (handler_index == H_CUFF1) {
        MakeCuff1();
    } else if (handler_index == H_CUFF2) {
        MakeCuff2();
    } else if (handler_index == H_CUFF3) {
        MakeCuff3();
    } else if (handler_index == H_CUFF_LEATHER_TEMPLATE) {
        MakeCuffLeatherTemplate();
    } else if (handler_index == H_ARM_UPPER) {
        MakeArmUpper();
    } else if (handler_index == H_ARM_LOWER) {
        MakeArmLower();
    } else if (handler_index == H_RATCHET) {
        MakeRatchet();
    } else if (handler_index == H_TENSIONER_PROBE) {
        MakeTensionerProbe();
    } else if (handler_index == H_SA_TENSIONER_LEVER) {
        MakeSATensionerLever();
    } else if (handler_index == H_EA_TENSIONER_LEVER) {
        MakeEATensionerLever();
    } else if (handler_index == H_EA_TENSIONER_HOLD) {
        MakeEATensionerHold();
    } else if (handler_index == H_SA_TENSIONER_HOLD) {
        MakeSATensionerHold();
    } else if (handler_index == H_CUFF2_HUB) {
        MakeCuff2Hub();
    } else if (handler_index == H_GRASP_LATCH_BASE) {
        MakeGraspLatchBase();
    } else if (handler_index == H_GRASP_LATCH_PROBE) {
        MakeLatchProbe();
    } else if (handler_index == H_PALM_BOLT) {
        MakePalmBolt();
    } else if (handler_index == H_PALM) {
        MakePalm();
    } else if (handler_index == H_WRIST_BUTTON) {
        MakeWristButton();
    } else if (handler_index == H_WRIST_COVER) {
        MakeWristCover();
    } else if (handler_index == H_PALM_TOP) {
        MakePalmTop();
    } else if (handler_index == H_INDEX_FINGER_END) {
        IndexFingerEnd();
    } else if (handler_index == H_INDEX_FINGER_PHALANX) {
        IndexFingerPhalanx();
    } else if (handler_index == H_MIDDLE_FINGER_END) {
        MiddleFingerEnd();
    } else if (handler_index == H_MIDDLE_FINGER_PHALANX) {
        MiddleFingerPhalanx();
    } else if (handler_index == H_PINKY_FINGER_END) {
        PinkyFingerEnd();
    } else if (handler_index == H_PINKY_FINGER_PHALANX) {
        PinkyFingerPhalanx();
    } else if (handler_index == H_RING_FINGER_END) {
        RingFingerEnd();
    } else if (handler_index == H_RING_FINGER_PHALANX) {
        RingFingerPhalanx();
    } else if (handler_index == H_THUMB_END) {
        ThumbEnd();
    } else if (handler_index == H_THUMB_PHALANX) {
        ThumbPhalanx();
    } else if (handler_index == H_WHIPPLETREE_PRIMARY) {
        WhippleTreePrimary();
    } else if (handler_index == H_WHIPPLETREE_SECONDARY) {
        WhippleTreeSecondary();
    } else if (handler_index == H_PENCIL_HOLDER_COVER) {
        PencilHolderCover();
    } else if (handler_index == H_HINGES) {
        MakeHinges();
    } else {
        echo(str("Unknown handler index: ", handler_index));
    }
}

module render_selected_part() {
    part_index = find_part_index(Part);

    if (part_index >= 0) {
        selected_spec = PART_SPECS[part_index];
        apply_mirror(selected_spec[PART_MIRROR])
            rotate(a=selected_spec[PART_ROTATION])
                run_part_handler(selected_spec[PART_HANDLER]);
    } else {
        echo(str("Unknown Part: ", Part));
    }
}

render_selected_part();
    
//***************************
// MakeHinges() 
//***************************
module MakeHinges() {
    
    // Hinge4Knuckles
   translate([0,  1* HandScale *10,0]) cube([HandScale*132,  HandScale*7 -0.5, HandScale*2.5 - 0.5]); 
   
   translate([0,  2* HandScale *10,0]) cube([HandScale*132,  HandScale*7 -0.5, HandScale*2.5 - 0.5]); 
        
    color("blue")translate([0,  3* HandScale *10,0]) cube([HandScale*132,  HandScale*7 -0.5 +.2, HandScale*2.5 - 0.5+.2]);      
      
   color("blue")translate([0,  4* HandScale *10,0]) cube([HandScale*132,  HandScale*7 -0.5 +.2, HandScale*2.5 - 0.5+.2]);  
         
   color("red")translate([0,  5* HandScale *10,0]) cube([HandScale*132,  HandScale*7 -0.5 +.4, HandScale*2.5 - 0.5+.4]);  
            
   color("red")translate([0,  6* HandScale *10,0]) cube([HandScale*132,  HandScale*7 -0.5 +.4, HandScale*2.5 - 0.5+.4]);  
}
    
//***************************
// PencilHolderCover() 
//***************************
module PencilHolderCover() {
    
    ShortestPencilCover = 27*HandScale;
    
    cube([ShortestPencilCover + PencilCoverAddedLength, 1.5*HandScale, 12*HandScale]);
    
    translate([0, -0.25 * HandScale, 6 * HandScale]) cylinder(d=3.5*HandScale, h = 12*HandScale, center=true, $fn=30);
    
    translate([ShortestPencilCover + PencilCoverAddedLength, -0.25 * HandScale, 6 * HandScale]) cylinder(d=3.5*HandScale, h = 12*HandScale, center=true, $fn=30);
    }

//***************************
// MakePalm() 
//***************************
module MakePalm() {
    
    difference(){
        Palm();
        
        translate([0 , 0, -HandScale * 15.5 + 3.5+ 5+5])PalmCutTool();

        // cut  first hole for bolt to hold palm together
        translate([HandScale * 12,0, HandScale * 84.35]) rotate([90,0,7]) cylinder(d=PalmBoltDiameter + 0.5,  h=100,center=true, $fn=20);
        translate([HandScale * 12, 0, HandScale * 84.35]) rotate([90,0,7]) translate([0, 0, -PalmBoltDiameter + 2 * HandScale])  cylinder(d=PalmBoltDiameter  + PalmBoltDiameter/2 + 1, h=100,center=false, $fn=20);
        
        // cut  second hole for bolt to hold palm together
        translate([HandScale * -32.767,0,HandScale * 76.472]) rotate([90,0,7]) cylinder(d=PalmBoltDiameter + 0.5, h=100,center=true, $fn=20);
        translate([HandScale * -32.767, 0,HandScale * 76.472]) rotate([90,0,7]) translate([0, 0, -PalmBoltDiameter + 2 * HandScale]) cylinder(d=PalmBoltDiameter + PalmBoltDiameter/2 + 1 + 0.5, h=100,center=false, $fn=20);
 
  
        // cut small hole all the way through wrist
        translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + (-2 * HandScale) / 2 ]) 
        cylinder(d = 19, h = 46.00 * HandScale, center=true, $fn=60);
       
       //This is the thickness of the button ring that holds the teeth 
       ringthickness = max (2.0, 6 * HandScale* HandScale);
        
       // cut larger hole to hold the wrist cover
        translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + 4.25 / 2 ]) 
        cylinder(r = 10+ ringthickness + 4, h = 5, center=true, $fn=30);
        
        //Cut slot for button     
        translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + 4.25]) {
            hull(){translate([0, -4.75, 0])linear_extrude(5.5) circle((20)/2 + ringthickness);
                translate([0, 2.75, 0])linear_extrude(5.5) circle((20)/2 + ringthickness);
                
            }
                //The two side square cutouts
                translate([-(6 + (3.7+ringthickness)/2), -(7.5+ringthickness/2)/2  -2.75, 2.75])cube([  3.7+ringthickness,7.5+ringthickness/2 ,5.5 ], center=true);
                
                translate([(6 + (3.7+ringthickness)/2), -(7.5+ringthickness/2)/2  -2.75, 2.75])cube([  3.7+ringthickness,7.5+ringthickness/2 ,5.5 ], center=true);
        }
            
        //Cut pin guide holes for Wrist cover
        translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + 4.5]) {
            translate([ -(10 + ringthickness +2) + 3, 0, 0]) rotate(a=[90,-90,-90]) linear_extrude(5) polygon(points=[[0,-2.5],[5,0],[0,2.5]], paths=[[0,1,2]]);
            
            translate([ (10 + ringthickness +2)+2 , 0, 0]) rotate(a=[90,-90,-90]) linear_extrude(5) polygon(points=[[0,-2.5],[5,0],[0,2.5]], paths=[[0,1,2]]);
        }
        
        // cut square for button
        translate([WRIST_X, WRIST_Y +
        250, WRIST_Z_BASE + 9.75/2 -.5 ]) 
        cube([ 20.5, 500,9.75 +1], center=true);
  
        // If the pencil holder is selected then cut it out
        if(PencilHolder =="Yes")
        {
            PencilHolderTool();
        }
        
    }
           
}

/***************************
// MakeWristCover() 
//***************************/
module MakeWristCover() {

       //This is the thickness of the button ring that holds the teeth 
       ringthickness = max (2.0, 6 * HandScale* HandScale);
        
difference(){
    union() {
       // make the main ring that is the cover
    translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + 4.25 / 2 ]) 
        cylinder(r = 10+ ringthickness + 3.75, h = 4.25, center=true, $fn=30);
    
            //make pin guide holes
        translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + 4.5]) {
            translate([ -(10 + ringthickness +2) + 1.5, 0, -1]) rotate(a=[90,-90,-90]) linear_extrude(3) polygon(points=[[0,-2],[4,0],[0,2]], paths=[[0,1,2]]);
            
            translate([ (10 + ringthickness +2)+1.5 , 0, -1]) rotate(a=[90,-90,-90]) linear_extrude(3) polygon(points=[[0,-2],[4,0],[0,2]], paths=[[0,1,2]]);
        }
    }
    
    // cut square for button
    translate([WRIST_X, WRIST_Y +
        250 +10.5, WRIST_Z_BASE + 9.75/2 -.5 ]) 
        cube([ 20.5, 500,9.75 +1], center=true);
    
    // cut small hole all the way through wrist
    translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + (-2 * HandScale) / 2 ]) 
        cylinder(d = 19, h = 36.00 * HandScale, center=true, $fn=60);
    
    }
}

/***************************
// MakeWristButton() 
//***************************/
module MakeWristButton() {

    intersection(){
        Palm();
        //  square to cut button top out of hand piece
        translate([WRIST_X, (WRIST_Y)+
    250+13.95, WRIST_Z_BASE + 9.5/2 +.3]) 
    cube([ 20, 500,8.5 ], center=true);
    }

    thickness = 4.8;
    //teeth
    translate([WRIST_X, WRIST_Y, WRIST_Z_BASE]) {
        translate([-6.75, -7.0, 14/2-.1]) cube([ 4, 3,thickness], center=true);
        translate([6.75, -7.0, 14/2-.1]) cube([ 4, 3,thickness], center=true);
        
        translate([ 2.35, -8.95, 14/2-2.5])
         rotate(a=[0, 0,-30])linear_extrude(thickness) polygon(points=[[1.75,1.75],[-1.75,1.75],[-1.75,-1.75],[1,-1]], paths=[[0,1,2,3]]);
        
        translate([-2.35, -8.95, 14/2-2.5]) 
        rotate(a=[0, 0,30])linear_extrude(thickness) polygon(points=[[1.75,1.75],[-1.75,1.75],[-1,-1],[1.75,-1.75]], paths=[[0,1,2,3]]);
    }
    
    //thicken the outside ring of the button
    ringthickness = max (2.0, 6 * HandScale* HandScale);
    
    translate([WRIST_X, WRIST_Y, WRIST_Z_BASE + 4.5])
    difference(){
        
        union(){
        
        //outer rings
        hull(){
            linear_extrude(thickness) circle((19.5)/2 + 1.5);
            translate([0, 2.75, 0])linear_extrude(thickness) circle((19)/2 + ringthickness);
            }
            
        MakeWristButtonSprings(ringthickness);
        
        //  square to connect to button top
        translate([0, 7, 2.4])cube([ 20, 14,thickness ], center=true);
        
        // two squares out side of ring
        translate([6 + (3.7+ringthickness)/2 -0.25, -(thickness+ringthickness/2)/2, 2.4])cube([  3.7+ringthickness,10+ringthickness/2 ,thickness ], center=true);
        
        translate([-(6 + (3.7+ringthickness)/2)+0.25, -(thickness+ringthickness/2)/2, 2.4])cube([  3.7+ringthickness,10+ringthickness/2 ,thickness ], center=true);
        
        }
        
        //Minus inner rings  
        hull(){translate([0, 0, -1])linear_extrude(10) circle(9.5);
            translate([0, 2.75, -1])linear_extrude(10) circle(9.5);
            }
        
    }
        
}

/***************************
// MakeWristButtonSprings() 
//***************************/
module MakeWristButtonSprings(ringthickness) {

thickness = 4.8;

difference() {

    for(j = [0 : 1.2: 4]) {
        //Springy piece 1
        difference(){
            translate([2.4, -4.5, 0])linear_extrude(thickness) circle((20)/2 + ringthickness - j);
            translate([2.4, -4.5, -0.5])linear_extrude(6) circle((20)/2 + ringthickness - (j+0.8));
        }
    }
    
    translate([10+ringthickness+2, -4, 2.4])rotate(a= [0,0,-20])cube([(10+ringthickness)*2,(10+ringthickness)*2,6 ], center=true);
        
    }
    
    translate([10+ringthickness+2, -4, 2.4])rotate(a= [0,0,-20])translate([-5.5 - 1.3*ringthickness/10 , -(10+ringthickness+0.5), 0])cube([6.5,1,thickness ], center=true);

}

//***************************
// MakePalmTop() 
//***************************
module MakePalmTop() {
    difference(){
        PalmTop();
        
        //Cut hole for first bolt holder
        translate([HandScale * 12, 0, HandScale * 84.35]) rotate([90,0,7]) translate([0, 0, -34 * HandScale])  cylinder(d=PalmBoltDiameter, h=100 * HandScale,center=false, $fn=20);
        
        //Cut hole for second bolt holder
        translate([HandScale * -32.767, 0,HandScale * 76.472]) rotate([90,0,7]) translate([0, 0,  -28 * HandScale]) cylinder(d=PalmBoltDiameter , h=100 * HandScale,center=false, $fn=20);
        
        
       
    }
   
     
    //Add inner threads for first bolt holder
    translate([HandScale * 12, 0, HandScale * 84.35]) rotate([90,0,7]) translate([0, 0, -35 * HandScale]) thread_in(PalmBoltDiameter, 13 * HandScale);
    
    //Add inner threads for second bolt holder
    translate([HandScale * -32.767, 0,HandScale * 76.472]) rotate([90,0,7]) translate([0, 0,  -29.5 * HandScale])  thread_in(PalmBoltDiameter, 13 * HandScale);
   
}


//***************************
// MakeCuff2Hub() 
//***************************
module MakeCuff2Hub() {

    //Elbow bolts are always 8 mm now

    difference(){
        Cuff2Hub();
        
        //Cut hole for elbow bolt
        cylinder(d=8, h=100,center=true, $fn=20);
       
    }
   
     difference(){
        //Add inner threads for elbow bolt holder
        translate([0, 0,  -5])  thread_in(8, 20);
        
        //cut the threads clean at 9mm thickness
        translate([0, 0,  -5]) cylinder(d=10, h=10,center=true, $fn=20);
        translate([0, 0,  14]) cylinder(d=10, h=10,center=true, $fn=20);
        }
   
   
}


//***************************
// MakeGraspLatchBase() 
//***************************
module MakeGraspLatchBase() {

    //Elbow bolts are always 8 mm now

    difference(){
        GraspLatchBase();
        
        //Cut hole for elbow bolt
        translate([60.93, 15.738,  0]) cylinder(d=8, h=100,center=true, $fn=20);
       
    }
   
     difference(){
        //Add inner threads for elbow bolt holder
        translate([60.93, 15.738,  -5])  thread_in(8, 20);
        
        //cut the threads clean at 9mm thickness
        translate([60.93, 15.738,  -5]) cylinder(d=10, h=10,center=true, $fn=20);
        translate([60.93, 15.738,  14]) cylinder(d=10, h=10,center=true, $fn=20);
        }
   
}

//***************************
// MakeTensionerProbe() 
//***************************
module MakeTensionerProbe() {

    //this bolts is always 3 mm 
    difference(){
        TensionerProbe();
        
        //Cut hole for elbow bolt
        translate([9.254, 3.273,  6.26]) cylinder(d=3, h=9.4,center=true, $fn=20);
       
    }
   
     difference(){
        //Add inner threads for elbow bolt holder
        translate([9.254, 3.273,  6.26-5])  thread_in(3, 10);
        
        //cut the threads clean
        translate([9.254, 3.273,  6.26+5]) cylinder(d=5, h=10,center=true, $fn=20);
        }
   
}

//***************************
// MakeSATensionerLever() 
//***************************
module MakeSATensionerLever() {

difference(){
union(){
    // under elbow hoop
    translate([0,27,0])
    difference() {
      cylinder(h = 16, r = ForearmDiameterWPadding/2+ArmShellThickness+ 6, $fn=40, center= true);
      translate([0, 0, -1])
        cylinder(h = 20, r = ForearmDiameterWPadding/2+ArmShellThickness, $fn=40, center= true);
        translate([0, -(ForearmDiameterWPadding/2+ArmShellThickness+ 10),-2]) cube([ForearmDiameterWPadding+ArmShellThickness*2+ 20,ForearmDiameterWPadding+ArmShellThickness*2+ 20,  24], center= true);
    }
        
    // inside hoop end
    translate([ -(ForearmDiameterWPadding/2+ArmShellThickness+3),0,0])
    rotate(a=[0,90,0])cylinder(h = 6, r = 8, $fn=40, center= true);
    translate([ -(ForearmDiameterWPadding/2+ArmShellThickness+3),027/2,0])
    cube([6,27,  16], center= true);

    //outside hoop end
    translate([ (ForearmDiameterWPadding/2+ArmShellThickness+23.5/2),0,0])
    rotate(a=[0,90,0])cylinder(h = 23.5, d = 29, $fn=40, center= true);
    translate([ (ForearmDiameterWPadding/2+ArmShellThickness+3),027/2,0])
    cube([6, 27, 16], center= true);

    //Top two loop connector on outside hoop end 
    intersection(){

        translate([ (ForearmDiameterWPadding/2+ArmShellThickness+23.5/2),0,0])
            rotate(a=[0,90,0])cylinder(h = 23.5, d = 42, $fn=40, center= true);
        union(){
        translate([ (ForearmDiameterWPadding/2+ArmShellThickness+3),027/2,11])
            cube([6, 27, 22], center= true);
        translate([ (ForearmDiameterWPadding/2+ArmShellThickness+12),2,0])
            cube([26, 15.5, 44], center= true);
            }
            
         translate([ (ForearmDiameterWPadding/2+ArmShellThickness+12),2,11])
            cube([26, 44, 22], center= true);
        }
     } //close main union of building

     
    // cut outside hoop end
    translate([ (ForearmDiameterWPadding/2+ArmShellThickness+15/2 + 6),0,0])
    rotate(a=[0,90,0])cylinder(h = 15, d = 29.1, $fn=40, center= true);
 
    translate([ (ForearmDiameterWPadding/2+ArmShellThickness+ 1.5),0,0])
    rotate(a=[0,90,0])cylinder(h = 4, d = 29.1, $fn=40, center= true);
    
    translate([ (ForearmDiameterWPadding/2+15),0,0])
    rotate(a=[0,90,0])cylinder(h = 30, d = 14, $fn=40, center= true);
    
    translate([ (ForearmDiameterWPadding/2+ArmShellThickness+ 1.5),0,0])
    rotate(a=[65,0,0])cube([4, 6.5*2, 100], center= true);
    
    translate([ (ForearmDiameterWPadding/2+ArmShellThickness+15/2 + 6),0,0])
    rotate(a=[-65,0,0])cube([15, 13*2, 100], center= true);
    
    // cut out inside hoop end
    translate([ -(ForearmDiameterWPadding/2+ArmShellThickness+3),0,0])
    rotate(a=[0,90,0])cylinder(h = 8, d = 8.5, $fn=40, center= true);
    
    translate([ -(ForearmDiameterWPadding/2+ArmShellThickness-5+2.5),0,0])
     rotate(a=[44,0,0])cube([10, 13*2, 100], center= true);
     
    //Holes in under elbow hoop
    translate([ -(ForearmDiameterWPadding/4),ForearmDiameterWPadding/2,0])
    rotate(a=[90,0,0])cylinder(h =ForearmDiameterWPadding*2, d = 5, $fn=40, center= true);
    
    translate([ (ForearmDiameterWPadding/4),ForearmDiameterWPadding/2,0])
    rotate(a=[90,0,0])cylinder(h =ForearmDiameterWPadding*2, d = 5, $fn=40, center= true);
    
  
  }


}

//***************************
// MakePalmBolt() 
//***************************
module MakePalmBolt()
{
    difference() {
        
        union(){
        // bolt
        thread_out_centre(PalmBoltDiameter, HandScale * 23);
            
        //threads
        difference() {
        translate([0, 0, -1 * HandScale  ])thread_out(PalmBoltDiameter, HandScale * 27);
        
        translate([0, 0, HandScale * -5]) cylinder(d=PalmBoltDiameter + 1, h=HandScale * 10,center=true, $fn=20);
           
    }
        
        // head
        hull() {
        
            translate([0, 0, (HandScale * 23)])cylinder(d=PalmBoltDiameter  + PalmBoltDiameter/2, h=.25,center=true, $fn=20);
            
            translate([0, 0, (HandScale * 23)+PalmBoltDiameter*.75])cylinder(d=PalmBoltDiameter  + PalmBoltDiameter/2, h=.25,center=true, $fn=20);
            }
        }
 
    //slot
    translate([0, 0, (HandScale * 23)+(PalmBoltDiameter*.9)/2])cube([1.5, PalmBoltDiameter *1.15, PalmBoltDiameter*.75],center=true);
    }
}


//***************************
// dropZ converts a set of points from 3d to 2d by removing Z
//***************************
function dropZ(path3d) = 
    concat([for (point = path3d)
   
      // Emit the twoD version
      [point.x, point.y]
  ]);

    
//***************************
// FlipHorzToVertPaths Flips the array of horizonatl paths to verticle paths. This assuems there are the same number of points in all the horizontal paths and they align verically.
//***************************
function FlipHorzToVertPaths(paths3d) = 
    [for(i = [0 : 1: len(paths3d[0])-1]) 
        
    concat([for(j = [0 : 1: len(paths3d)-1])
   
      [paths3d[j][i].x, paths3d[j][i].y,paths3d[j][i].z]
  ])];

//***************************
// Sphere points
// makes a sperere at each point on the path
//***************************
module SpherePoints(path, width=1)
{
    for (i = [0 : len(path) - 1]) {
        translate(path[i])
          cube(width);
    }
}

    
//***************************
// ScaleXY scales all xy values
//***************************
function ScaleXY(path3d, s) = 
    concat([for (point = path3d)
   
      // Emit the scaled version
      [point.x * s, point.y *s, point.z]
  ]);

//add an array of numbers
function add(v, i=0, r=0) = i<len(v) ? add(v, i+1, r+v[i]) : r;

//Lengths of all the path segments in a loop
function lengths(v) = [for(i=[0:len(v)-1]) i < len(v)-1 ? norm(v[i+1]-v[i]) : norm(v[0]-v[i]) ];


// Finds the weighting of a value between two values, with an ease-out effect (using pow)
// 'ease' controls the strength of the ease-out (ease > 1 for more pronounced easing)
function weighting_ease_out(low, high, dist, ease) =
    (high == low)
        ? 0
        : pow((dist - low) / (high - low), ease);

        
//finds the highest non-zero circumfernece filled by the user
function HighestCircumference(Circumferences, i = 0) = 
    (Circumferences[i] > 0 && i < (len(Circumferences)-1)) ? 
        HighestCircumference(Circumferences, i +1) : i -1;

//Gets the Circumference of the path at "near" z
function circumferenceAt(Paths, i = 0, z) = 
    (-(Paths[i][0].z) >= z || i < (len(Paths)-1)) ? 
        add(lengths(Paths[i])) * 1.026 :  
        circumferenceAt(Paths, i + 1, z);


//***************************
// MakeArmLoft() 
//***************************
module MakeArmLoft(Circumferences, minCircumferenceScale, smoothness, isInnerLoft) {
    
    //These points describe a "by hand" scultpted arm. 
    //The code pulls and stretches this version to fit the measurements given.
    OrigArmPaths = [
        [[51.8, 4, 0], [34.8, 34.2, 0], [5.62, 45.8, 0], [-26.8, 34.7, 0], [-40.3, -2.2, 0], [-25.9, -35.2, 0], [7, -47.9, 0], [39.7, -32.8, 0]],
        [[46.3, 4.4, -103], [35.2, 30.7, -103], [7.7, 43, -103], [-21.1, 35.2, -103], [-37.8, 8.2, -103], [-32.2, -26.8, -103], [0.2, -42.6, -103], [34.2, -31.3, -103]],
        [[33.7, -4.5, -190], [33.3, 16.6, -190], [15, 31.9, -190], [-11.9, 27.6, -190], [-28.4, 12.9, -190], [-31, -14.4, -190], [-13.2, -27.8, -190], [15.2, -25.5, -190]],
        [[26.7, 2.4, -248], [16.6, 20.4, -248], [-0.1, 26.3, -248], [-16.5, 20.8, -248], [-27.1, 0.6, -248], [-18.9, -18.6, -248], [1, -26.3, -248], [20.1, -17.7, -248]],
        [[26.3, 2.8, -271], [16.3, 21.1, -271], [1, 26.9, -271], [-16.9, 20.9, -271], [-27.1, 0.2, -271], [-19, -18.8, -271], [0.5, -26.6, -271], [20.4, -16.8, -271]]
    ];

    // === 1. Scale original paths according to ArmLengthScale ===
    OrigScaleLength = [
        for (ring = OrigArmPaths)
            [for (pt = ring) [pt.x, pt.y, pt.z * ArmLengthScale]]
    ];

    // === 2. Convert horizontal rings to vertical paths (and back, for smoothing) ===
    OrigVerticalPaths = FlipHorzToVertPaths(OrigScaleLength);

    LightlySmoothedVertPaths = [
        for (path = OrigVerticalPaths)
            smooth(path, 3, false)
    ];
    LightHorzPaths = FlipHorzToVertPaths(LightlySmoothedVertPaths);
    

    max_index = HighestCircumference(Circumferences, 0);
    h_circumference = circumferenceAt(LightHorzPaths, 0, max_index*25 );
    
    
    // === 3. Scale diameters to fit target circumferences ===
    ScaledHorzPaths = 
        [for (a = [0 : 1: len(LightHorzPaths) - 1])
      
            let (
                // NOTE my rings are currently just octogons. (or pretty close to it)
                // The ratio of the perimeter of an octogon to the ciurcumfernce of the
                //  same cirlce is 1.026 I am saving some calulation time and just using this fact.
                ring = LightHorzPaths[a],
                circ = add(lengths(ring)) * 1.026,
            
            
                // Circumference interpolation index and blend factor
                z = -ring[0].z,
                indexCircRaw = (z > 25) ? floor(z / 25) : 0,
                indexCirc = min(indexCircRaw, len(Circumferences) - 1),
                hasCircAtIndex = Circumferences[indexCirc] > 0,
                
                //The index of the last Circumference filled
                h_index = hasCircAtIndex ? indexCirc : max(0, max_index),
                
                diff = ((indexCirc+1)  - h_index) * 25,
                
                weightCirc = weighting_ease_out(h_index*25, min((indexCirc+1)*25, ArmLength), z, 1),
                
                // I want this to eas out of the h_index value, but it never seems to work right
                weightCirc_wrist = weighting_ease_out(h_index*25, min((indexCirc+1)*25, ArmLength), z,1.0),

                // Linear interpolation of scale between two circumference samples
                scaleCirc = (
                    indexCirc < len(Circumferences) - 1 && hasCircAtIndex
                ) ? (
                    Circumferences[indexCirc] / circ * (1 - weightCirc)
                    + ((Circumferences[indexCirc + 1] < 1)
                        ? minCircumferenceScale * weightCirc
                        : Circumferences[indexCirc + 1] / circ * weightCirc)
                ) : (
                    isInnerLoft
                        ? minCircumferenceScale
                        : Circumferences[h_index] / h_circumference * (1 - weightCirc_wrist)
                            + minCircumferenceScale * weightCirc_wrist
                ),
                // Allow scale to drop to min only in lower half of arm
                blend = min(1.0, z / (ArmLength / 2)),
                
                scaleFinal = (scaleCirc > minCircumferenceScale)
                    ? scaleCirc
                    : blend * minCircumferenceScale + (1 - blend) * scaleCirc
            ) 
                ScaleXY(ring, scaleFinal)
            
        ];
    
    // === 4. Smooth again after scaling ===
    ScaledVertPaths = FlipHorzToVertPaths(ScaledHorzPaths);

    FullySmoothedVertPaths = [
        for (path = ScaledVertPaths)
            smooth(path, 1, false)
    ];

    manyHorzPaths = FlipHorzToVertPaths(FullySmoothedVertPaths);

    // === 5. Loft: build hulls between consecutive rings ===
    translate([0, -4 * ForeArmCircumferenceScale, 0])
    rotate([0, 0, 94])
    mirror([0, 1, 0])
    union() {
        for (i = [0 : len(manyHorzPaths) - 2]) {
            hull() {
                translate([0, 0, manyHorzPaths[i][3].z])
                    linear_extrude(0.2)
                        polygon(dropZ(smooth(manyHorzPaths[i], smoothness, true)), convexity = 0);

                translate([0, 0, manyHorzPaths[i + 1][0].z])
                    linear_extrude(0.2)
                        polygon(dropZ(smooth(manyHorzPaths[i + 1], smoothness, true)), convexity = 0);
            }
        }
    }
    
}

 
//***************************
// MakeArmUpper() 
//***************************
module MakeArmUpper() {

    // The wrist bolt is a fixed not adjustable model now. 
    writstBoltLength = 21.5;

    outerShell = concat([for (circum = ForearmCircumferences)

    // Add padding and shell thickness
    circum < 1 ? 0 : ((circum/PI) + 2*PaddingThickness + 2*ArmShellThickness)*PI
    ]);

    innerShell = concat([for (circum = ForearmCircumferences)

    // Add padding and NO shell thickness
    circum < 1 ? (WristBoltDia)*PI : ((circum/PI) + 2*PaddingThickness)*PI
    ]);

    //The top of the socket is off center a little, compaired to the wrist
    elbowCenterOffset = 1.5*ForeArmCircumferenceScale;

    elbowCentertoSocketCutTop = 13;
    cornerRadius = 4;
    blockThickness = 7;
    bigBlockHeight = 55;
    smallBlockHeight = 18;
    blockWidth = 35;
    
    difference() {
        union(){
            difference() {
            
                MakeArmLoft(outerShell, HandScale, 4, false);

                // We cut the top off down from elbow center
                translate([0,0,-elbowCentertoSocketCutTop])cube([2*ForearmDiameterWPadding,2*ForearmDiameterWPadding,elbowCentertoSocketCutTop],true);
                 
                //clear out the top in a nice curved shape
                elbowclearingtool = concat([[-ForearmDiameterWPadding/2-4*ArmShellThickness,  ElbowPartsScale*40]], 
                    smooth([
                        [-ForearmDiameterWPadding/2- 4*ArmShellThickness ,  -ElbowPartsScale*8],
                        [-ForearmDiameterWPadding/4, -ForearmDiameterWPadding/4],
                        [ForearmDiameterWPadding/4, -ForearmDiameterWPadding/4],
                        [ForearmDiameterWPadding/2+4*ArmShellThickness, -ElbowPartsScale*8]], 3, false),
                    [[ForearmDiameterWPadding/2+4*ArmShellThickness, ElbowPartsScale*40]]);

                translate([ 0, 10,0])rotate(a=[110,0,0])translate([ 0, 0,-ForearmDiameterWPadding])linear_extrude(ForearmDiameterWPadding*2) polygon(elbowclearingtool);
                translate([ 0, 5,-ForearmDiameterWPadding/4])rotate(a=[120,0,180])linear_extrude(ForearmDiameterWPadding*2) polygon(elbowclearingtool);

                    
                // CUT OFF the bottom half of the arm. 
                // We make the arm in two parts. We had to loft the entire arm 
                // so it is smooth top to bottom
                translate([-ForearmDiameterWPadding, -ForearmDiameterWPadding, -ArmSplitLength-ArmLength])cube([ ForearmDiameterWPadding*2, ForearmDiameterWPadding*2, ArmLength], center= false);
            }

            //Add a shape that allows the latch base to attach to

            hull() {
                translate([ForearmDiameterWPadding/2 + blockThickness - cornerRadius, blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);
                translate([ForearmDiameterWPadding/2 + blockThickness - cornerRadius, -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);

                translate([ForearmDiameterWPadding/2 + blockThickness - cornerRadius, blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - bigBlockHeight])sphere(d=cornerRadius*2);
                translate([ForearmDiameterWPadding/2 + blockThickness - cornerRadius, -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - bigBlockHeight])sphere(d=cornerRadius*2);

                translate([ForearmDiameterWPadding/4 , blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);
                translate([ForearmDiameterWPadding/4 , -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);

                translate([ForearmDiameterWPadding/4 , blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - bigBlockHeight - ForearmDiameterWPadding/4])sphere(d=cornerRadius*2);
                translate([ForearmDiameterWPadding/4 , -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - bigBlockHeight - ForearmDiameterWPadding/4])sphere(d=cornerRadius*2);
            }

            //Add a shape for the secondary latch base to attach to
            //translate([-ForearmDiameterWPadding/4  -5 ,0,-elbowCentertoSocketCutTop - 18/2])cube([ForearmDiameterWPadding/2 + 5,35,18],true);
            hull() {
                translate([-(ForearmDiameterWPadding/2 + blockThickness - cornerRadius), blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);
                translate([-(ForearmDiameterWPadding/2 + blockThickness - cornerRadius), -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);

                translate([-(ForearmDiameterWPadding/2 + blockThickness - cornerRadius), blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - smallBlockHeight])sphere(d=cornerRadius*2);
                translate([-(ForearmDiameterWPadding/2 + blockThickness - cornerRadius), -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - smallBlockHeight])sphere(d=cornerRadius*2);

                translate([-(ForearmDiameterWPadding/4), blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);
                translate([-(ForearmDiameterWPadding/4), -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop - cornerRadius])sphere(d=cornerRadius*2);

                translate([-(ForearmDiameterWPadding/4), blockWidth/2 - cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - smallBlockHeight - ForearmDiameterWPadding])sphere(d=cornerRadius*2);
                translate([-(ForearmDiameterWPadding/4), -blockWidth/2 + cornerRadius, -elbowCentertoSocketCutTop + cornerRadius - smallBlockHeight - ForearmDiameterWPadding])sphere(d=cornerRadius*2);
            }

        }

        //cut the slots for the larger latch base to slide into
        translate([ForearmDiameterWPadding/2 + 3 ,0,-elbowCentertoSocketCutTop - 53/2])cube([3,28,55],true);
        translate([ForearmDiameterWPadding/2 + 6 ,0,-elbowCentertoSocketCutTop - 45/2])cube([5,24,50],true);


        // Cut a hole for the through bolt that holds latch bas in place. This is always a 5.5 mm hole, and it is always 48 mm from the top of the arm
        translate([ForearmDiameterWPadding/2, 7.65,  - 48]) rotate(a=[90,0,90]) cylinder(d=5.5, h=ForearmDiameterWPadding/4,center=true, $fn=40);
        translate([ForearmDiameterWPadding/2- ForearmDiameterWPadding/8, 7.65,  - 48]) rotate(a=[90,0,90]) cylinder(d=10, h=ForearmDiameterWPadding/4,center=true, $fn=40);

        
        //cut the slots for the smaller latch base to slide into
        translate([-ForearmDiameterWPadding/2 - 3 ,0,-elbowCentertoSocketCutTop - elbowCentertoSocketCutTop/2])cube([3,28,17],true);
        translate([-ForearmDiameterWPadding/2 - 6 ,0,-elbowCentertoSocketCutTop - 10/2])cube([5,24,14],true);


        // Cut a hole for the through bolt that holds latch bas in place. This is always a 5.5 mm hole, and it is always 48 mm from the top of the arm
        translate([-(ForearmDiameterWPadding/2), 0,  - 21]) rotate(a=[90,0,90]) cylinder(d=5.5, h=ForearmDiameterWPadding/4,center=true, $fn=40);
        translate([-(ForearmDiameterWPadding/2 - ForearmDiameterWPadding/8), 0,  - 21]) rotate(a=[90,0,90]) cylinder(d=10, h=ForearmDiameterWPadding/4,center=true, $fn=40);
        translate([-(ForearmDiameterWPadding/2+ ForearmDiameterWPadding/8+blockThickness/2), 0,  - 21]) rotate(a=[90,0,90]) cylinder(d=10, h=ForearmDiameterWPadding/4,center=true, $fn=40);
    

        // the inner shell always leaves space for wrist bolt 
        //TODO this scale is not right
        wristdiameter = 53.39*HandScale;

        MakeArmLoft(innerShell,(wristdiameter-10- 3*ArmShellThickness)/wristdiameter , 2, true);
        
        // Make slot for thread to go into arm
        // it is always a 4 mm hole. Note this is likly in Lower Arm section, but just to be sure
        translate([ ForearmDiameterWPadding/4, 0, -ArmLength + 40]) rotate(a=[45,0,90]) cylinder(d=4, h=ForearmDiameterWPadding,center=true, $fn=20);

        // Check if the upper arm is the entire arm
        if(ArmSplitLength < ArmLength) {
        
          // cut out the lip space for lower arm
          scaleofShell = (ForearmDiameterWPadding-2*ArmShellThickness)/ForearmDiameterWPadding;
            
          scale([scaleofShell,scaleofShell,1])
              intersection(){
                //We need to reubild the arm loft in order to cut a 
                //  lip out of it to conenct the two arm sections.
                MakeArmShell(2);
                translate([0, 0, -ArmSplitLength])cube([ ForearmDiameterWPadding*2, ForearmDiameterWPadding*2, 2*ArmShellThickness + 2], center= true);
            }
        } else  {
          // cut large hole for wrist bolt threads
          // the -0.05 on bolt diamter is to make sure threads attach to walls
          translate([0, -4*ForeArmCircumferenceScale, -ArmLength + 8 * ForeArmCircumferenceScale]) cylinder(d = WristBoltDia - 0.05, h=writstBoltLength+100, center=true, $fn=30);
          
          // cut large hole for the wrist bolt insert.
          translate([0, -4*ForeArmCircumferenceScale, -ArmLength/2 + writstBoltLength]) cylinder(d =24, h=ArmLength, center=true, $fn=30);
            
          //Cut out the hole for wrist bolt pin, note the pin is always a #4 or 3mm sheet metal screw
          translate([ForearmDiameterWPadding/4 + 5 * ForeArmCircumferenceScale, -4*ForeArmCircumferenceScale, -ArmLength + 5.9]) 
          rotate(a=[0,90,0]) cylinder(d=3.5, h=ForearmDiameterWPadding/2,center=true, $fn=20);
            
          wristdiameter = 53.39*HandScale;
          //Countersink 5mm in for the head of the  wrist bolt pin, note the pin is always a #4 or 3mm sheet metal screw
          translate([ForearmDiameterWPadding/4 + wristdiameter/2 - 5, -4*ForeArmCircumferenceScale, -ArmLength + 5.9]) 
          rotate(a=[0,90,0]) cylinder(d=6.5, h=ForearmDiameterWPadding/2,center=true, $fn=20);
            
        }
        
                
    if(UpperVentingHoles != "None") {
        apply_venting_transform() render_upper_venting();
    }

    if(LowerVentingHoles != "None") {
        apply_venting_transform() render_lower_venting();
    }
    }
   
    // Check if the upper arm is the entire arm
    if(ArmSplitLength < ArmLength) {
        
        // Create a registration block
        difference() {
            //The scale to attach the block to body
            scaleofAttach = (ForearmDiameterWPadding-2*ArmShellThickness +0.5)/ForearmDiameterWPadding;


            scale([scaleofAttach,scaleofAttach,1])
              intersection(){
                //We need to reubild the arm loft in order to cut a 
                //  lip out of it to conenct the two arm sections.
                MakeArmShell(2);
                //Leave a registration block, this may or not be ther based on the hollowing
                translate([0, ForearmDiameterWPadding/2, -ArmSplitLength + ArmShellThickness + 0.5])cube([ 2*ArmShellThickness , ForearmDiameterWPadding/2, 2*ArmShellThickness+3], center= true);
            }
        
        // CUT OFF the registration flat with arm1
        translate([-ForearmDiameterWPadding, -ForearmDiameterWPadding, -ArmSplitLength-ArmLength])cube([ ForearmDiameterWPadding*2, ForearmDiameterWPadding*2, ArmLength], center= false);
        }
    } else {
        //add wrist bolt threads
        difference() {
                
             //Add inner threads for wrist bolt holder
            translate([0, -4*ForeArmCircumferenceScale, -ArmLength - 2 * ForeArmCircumferenceScale]) thread_in(WristBoltDia, writstBoltLength +10 );
            
             // truncate threads length to wrist end
            translate([0, -4*ForeArmCircumferenceScale, -ArmLength - ForearmDiameterWPadding/2]) cube(ForearmDiameterWPadding,center=true);
            
            // truncate threads inside so they do not extend up into the arm
            translate([0, -4*ForeArmCircumferenceScale, -ArmLength + ForearmDiameterWPadding/2+writstBoltLength ]) cube(ForearmDiameterWPadding,center=true);
            
          //Cut out the hole for wrist bolt pin, note the pin is always a #4 or 3mm sheet metal screw
          translate([ForearmDiameterWPadding/4 + 5 * ForeArmCircumferenceScale, 0, -ArmLength + 7.5 * ForeArmCircumferenceScale]) 
          rotate(a=[0,90,0]) cylinder(d=3.5, h=ForearmDiameterWPadding/2,center=true, $fn=20);
    
        }
    }
    
}

module MakeArmShell(smoothness) {

    // The wrist bolt is a fixed not adjustable model now. 
    writstBoltLength = 21.5;
        
    
    outerShell = concat([for (circum = ForearmCircumferences)

        // Add padding and shell thickness
        circum < 1 ? 0 : ((circum/PI) + 2*PaddingThickness + 2*ArmShellThickness)*PI
    ]);

    innerShell = concat([for (circum = ForearmCircumferences)

        // Add padding and shell thickness
        circum < 1 ? (WristBoltDia)*PI : ((circum/PI) + 2*PaddingThickness)*PI
    ]);
    difference() {
        MakeArmLoft(outerShell, HandScale, smoothness, false);
        
        // the inner shell always leavs space for wrist bolt 
        //TODO this scale is not right
        wristdiameter = 53.39*HandScale;//HandScale;

        //Hollow out the center space 
        MakeArmLoft(innerShell, (wristdiameter- 10-3*ArmShellThickness)/wristdiameter, 2, true);//(WristBoltDia
    }
    
    wristdiameter = 53.39*HandScale;
    //Add a cylinder for the wrist bolt threads to be cut from. 
   //Add inner threads for wrist bolt holder
    translate([0, -4*ForeArmCircumferenceScale, -ArmLength ]) cylinder(d = wristdiameter -4, h = writstBoltLength );
}

module MakeArmLip() {
    
  intersection(){
    //We need to rebuild the arm loft in order to cut a 
    //  lip out of it to conenct the two arm sections.
    MakeArmShell(2);
    
    translate([0, 0, -ArmSplitLength])cube([ ForearmDiameterWPadding*2, ForearmDiameterWPadding*2, 2*ArmShellThickness], center= true);
    
  }
}


//***************************
// MakeLowerArmLip() 
//***************************
module MakeLowerArmLip() {
    
    // The scale to include a 1 mm tollerance
    scaleofLip = (ForearmDiameterWPadding-2 * ArmShellThickness - 1 )/ForearmDiameterWPadding;

    //The scale to attach the lip to body
    scaleofCutTool = (ForearmDiameterWPadding+1)/ForearmDiameterWPadding;

    //the main lip
    scale([scaleofLip,scaleofLip,1])children();

    //  Make a set of concentric rings to angle the bottom of this lip for easier printing.
    for(i = [ 1 : 10])
        difference() {
            
          s = scaleofLip + i*(1-scaleofLip)/10;
          drop = -i*(ArmShellThickness/10);
          translate([0,0,drop])scale([s,s,1])children();
        
       
          // echo("scaleofLip", s, drop);
       
          // CUT OFF the top of this attach lip. this bit attaches the actual lip to the arm itself. Since the lip itself must be smaller
          translate([-ForearmDiameterWPadding, -ForearmDiameterWPadding, -ArmSplitLength])cube([ ForearmDiameterWPadding*2, ForearmDiameterWPadding*2, ArmLength], center= false);
        
          //this cut makes sure the ring is only on the interior of the arm
          translate([0,0,drop+0.05*ArmSplitLength])scale([scaleofCutTool,scaleofCutTool,1.05])children();
        }

}

//***************************
// MakeArmLower() 
//***************************
module MakeArmLower() {
    
if(ArmSplitLength < ArmLength) {

    // The wrist bolt is a fixed not adjustable model now. 
    writstBoltLength = 21.5;
        
  //The top of the soceket is off center a little, compaired to the wrist
  elbowCenterOffset = 1.5*ForeArmCircumferenceScale;
  difference() {
      union(){   
        difference() {

            MakeArmShell(4);
        
            
            // CUT OFF the top half of the arm. 
            // We make the arm in two parts. We had to loft the entire arm 
            // so it is smooth top to bottom
            translate([-ForearmDiameterWPadding*2, -ForearmDiameterWPadding*2, -ArmSplitLength])cube([ ForearmDiameterWPadding*4, ForearmDiameterWPadding*4, ArmLength], center= false);
            
            // cut large hole for wrist bolt 
            // the -0.05 on bolt diamter is to make sure threads attach to walls
            translate([0, -4*ForeArmCircumferenceScale, -ArmLength + 8 * ForeArmCircumferenceScale]) cylinder(d = WristBoltDia - 0.05, h=writstBoltLength+100, center=true, $fn=30);
            
           // cut large hole for the wrist bolt insert.
           translate([0, -4*ForeArmCircumferenceScale, -ArmLength/2 + writstBoltLength]) cylinder(d =24, h=ArmLength, center=true, $fn=30);

            
        }
        
        //add a lip to connect to the Upper Arm 
        difference() {
       
            MakeLowerArmLip() MakeArmLip();
        
            //Cut a registration out of the lip
            translate([0, ForearmDiameterWPadding/2, -ArmSplitLength])cube([ 2*ArmShellThickness + 1, ForearmDiameterWPadding, 2*ArmShellThickness+3], center= true);
        }
        
        //add wrist bolt threads
        difference() {
          
             //Add inner threads for wrist bolt holder
            translate([0, -4*ForeArmCircumferenceScale, -ArmLength - 2 * ForeArmCircumferenceScale]) thread_in(WristBoltDia, writstBoltLength +10  );
            
             // truncate threads length to wrist end
            translate([0, -4*ForeArmCircumferenceScale, -ArmLength - ForearmDiameterWPadding/2]) cube(ForearmDiameterWPadding,center=true);
            
            // truncate threads inside so they do not extend up into the arm
            translate([0, -4*ForeArmCircumferenceScale, -ArmLength + ForearmDiameterWPadding/2+writstBoltLength]) cube(ForearmDiameterWPadding,center=true);
        }
   
    }
    
    //Cut out the hole for wrist bolt pin, note the pin is always a #4 or 3mm sheet metal screw
    translate([ForearmDiameterWPadding/4 + 5 * ForeArmCircumferenceScale, -4*ForeArmCircumferenceScale, -ArmLength + 5.9]) 
    rotate(a=[0,90,0]) cylinder(d=3.5, h=ForearmDiameterWPadding/2,center=true, $fn=20);
    
    wristdiameter = 53.39*HandScale;
    //Countersink 5mm in for the head of the  wrist bolt pin, note the pin is always a #4 or 3mm sheet metal screw
    translate([ForearmDiameterWPadding/4 + wristdiameter/2 - 5, -4*ForeArmCircumferenceScale, -ArmLength + 5.9]) 
    rotate(a=[0,90,0]) cylinder(d=6.5, h=ForearmDiameterWPadding/2,center=true, $fn=20);
    
    
    // Make hole for thread to go into arm
    // it is always a 4 mm hole
    translate([ ForearmDiameterWPadding/4, 0, -ArmLength + 40]) rotate(a=[45,0,90]) cylinder(d=4, h=ForearmDiameterWPadding,center=true, $fn=20);
    
    
     
    if(UpperVentingHoles != "None") {
        apply_venting_transform() render_upper_venting();
    }

    if(LowerVentingHoles != "None") {
        apply_venting_transform() render_lower_venting();
    }
    }
}

    
}

//***************************
// MakeCuffslots1() 
//***************************
module MakeCuffslots1() {
    
    for(y = [0 : (SlotWidth + SlotSize)*2 : BicepCircumferenceWPadding]){
        for(x = [0 : (SlotLength + SlotSpacing) :  CuffLength]){
            // the extra thickness is because the difference is not exact
            translate([x, y, -0.5])cube([ SlotLength,SlotSize, ShellThickness + 1]);
        }
    }

    for(y = [(SlotWidth + SlotSize) : (SlotWidth + SlotSize)*2 : BicepCircumferenceWPadding]){
        for(x = [-(SlotLength + SlotSpacing)/2 : (SlotLength + SlotSpacing) :  CuffLength + (SlotLength + SlotSpacing)]){
            // the extra thickness is because the difference is not exact
            translate([x, y, -0.5])cube([SlotLength, SlotSize, ShellThickness + 1]);
        }
    }
}


//***************************
// MakeCuffBase() 
//***************************
module MakeCuffBase(oneOrTwo, CuffWidth, CuffYoffset, offset, height) {

    
    difference() {
        union() {//91.5
            
        if(LeatherOrPlastic != "Leather")
        translate([CuffScale  * 49, CuffYoffset , 0 ])
             difference() {
                 union() {
                // the plate with slots
                difference() {
                    translate([0, 0 , 0 ]) cube([ CuffLength, CuffWidth, ShellThickness]);

                    MakeCuffslots1();
                }

                if(oneOrTwo == 1) {
                    //solid on end
                    translate([0, 0 , 0 ])cube([ CuffLength, 3*CuffScale, ShellThickness/2]);

                    //lip on leading edge to glue on other stiffener
                    translate([0, BicepCircumferenceWPadding/2 -CuffYoffset - 5.5*CuffScale- CuffScale * 0.25 , 0 ])cube([ CuffLength, 5.25*CuffScale , ShellThickness]);
                    translate([CuffLength, BicepCircumferenceWPadding/2 -CuffYoffset  - 1.25*CuffScale, ShellThickness ])
                    rotate(a=[90,-90,-90]) linear_extrude(CuffLength)
                        polygon(points=[[0,-1*CuffScale],[3*CuffScale,0],[0,1*CuffScale]], paths=[[0,1,2]]);
                    
                     
                } else {
                    
                    //Solid end
                    translate([0, BicepCircumferenceWPadding/2  -SlotSpacing - CuffScale * 8.5 - CuffScale * 4  , 0 ])cube([ CuffLength, SlotSpacing , ShellThickness]);
                }
            }
            
            if(oneOrTwo == 1){
                
                //Cut angle off glueable triangle end
                translate([CuffLength-  7*CuffScale, BicepCircumferenceWPadding/2 -CuffYoffset - 8.5*CuffScale- CuffScale * 0.25 , ShellThickness+ 7*CuffScale ])rotate(a=[0,45,0])cube([ CuffScale*10, CuffScale*10 , CuffScale*10]);
            }
            

            
        }

        // import cuff bolt holder
        if(oneOrTwo == 1) {
            MakeCuff1Imports();
        }
        
        if(oneOrTwo == 2) {
            MakeCuff2Imports();
        }
        
        // cuff stiffener
        hull() {
            rotate(a=[90,-90,-90]) translate([10,3.5, -CuffScale  * 49 -1])cylinder(d=4, h=1);
            rotate(a=[90,-90,-90]) translate([10,-3.5, -CuffScale  * 49 -1])cylinder(d=4, h=1);
            
            translate([CuffScale  * 49,-(11)/2,0])cube([CuffLength ,  11, ShellThickness,]);
            translate([ CuffScale  * 49 +CuffLength - 10*CuffScale, 3.5, 10])sphere(d=4);
            translate([CuffScale  * 49 +CuffLength - 10*CuffScale, -3.5, 10 ])sphere(d=4);
            
        }
        
        
        hull() {
            rotate(a=[90,-90,-90]) translate([10,3.5, -CuffScale  * 49 -1])cylinder(d=4, h=1);
            rotate(a=[90,-90,-90]) translate([10,-3.5, -CuffScale  * 49 -1])cylinder(d=4, h=1);
            rotate(a=[90,-90,-90]) translate([2,3.5, -CuffScale  * 49-1])cylinder(d=4, h=1);
            rotate(a=[90,-90,-90]) translate([2,-3.5, -CuffScale  * 49-1])cylinder(d=4, h=1);
            
            translate([25*ElbowPartsScale - 60*ElbowPartsScale +1,(12/2) - 1.5, offset+12*ElbowPartsScale + 1*ElbowPartsScale]) sphere(d=2);
           
            translate([25*ElbowPartsScale - 60*ElbowPartsScale +1 ,-(12/2) + 1.5, offset+12*ElbowPartsScale + 1*ElbowPartsScale]) sphere(d=2);
        
         translate([25*ElbowPartsScale - 60*ElbowPartsScale +1,(12/2) - 1.5, offset+height+11*ElbowPartsScale - 2*ElbowPartsScale]) sphere(d=2);
           
            translate([25*ElbowPartsScale - 60*ElbowPartsScale +1,-(12/2) + 1.5, offset+height+11*ElbowPartsScale - 2*ElbowPartsScale]) sphere(d=2);
            
            }
        }

        //slots for strap
        //translate([CuffScale  * 49 +CuffLength/2 - (StrapWidth + 1) /2,+ BicepCircumferenceWPadding/2 -12*CuffScale  , ShellThickness-8 ])cube([ StrapWidth + 1, 24*CuffScale, 30*ShellThickness]);
        
        //slots for strap
        translate([CuffScale  * 49 +CuffLength/2 - (StrapWidth + 1) /2, -12*CuffScale  , -ShellThickness +9])cube([ StrapWidth + 1, 24*CuffScale, 30*ShellThickness]);
        
        //slots for strap
        //translate([CuffScale  * 49 +CuffLength/2 - (StrapWidth + 1) /2,+ BicepCircumferenceWPadding/2 -12*CuffScale  , ShellThickness-8 ])cube([ StrapWidth + 1, 24*CuffScale, -CuffYoffset]);
        
        if(oneOrTwo == 1 || oneOrTwo == 2) {
            
            if(LeatherOrPlastic != "Leather") {
                // Cut opening for the other edge to glue in
              translate([CuffScale  * 49 -0.5,  - CuffScale * 0.25 + CuffScale  * -8.5 , -1.75 ])cube([ CuffLength +2, 8.25*CuffScale +.2, ShellThickness+2]);
                
              translate([CuffScale  * 49 + CuffLength +0.5,  +8.25*CuffScale + CuffScale  * -8.5  - 1.25*CuffScale, ShellThickness ])
                    rotate(a=[90,-90,-90]) linear_extrude(CuffLength + 2)
                    polygon(points=[[-0.1,-1*CuffScale-.2],[3*CuffScale+.2,0],[-0.1,1*CuffScale+.2]], paths=[[0,1,2]]);
            } else {
                // Cut bottom float for the leather to fit in.
              //translate([CuffScale  * 49 -0.5,  - CuffScale * 0.25 + CuffScale  * -8.5 , -1.75 ])cube([ CuffLength +2, 17*CuffScale +.2, ShellThickness+2]);
                
                //Cut the two holes for the leather rivets to go through
                translate([CuffScale  * 49 +CuffLength/5 , 0  , -ShellThickness ])
                cylinder(d=RivetShaftDiameter + 0.5, h = 200*CuffScale, center=true, $fn=30);
                
                translate([CuffScale  * 49 + 4*CuffLength/5, 0  , -ShellThickness ])
                cylinder(d=RivetShaftDiameter + 0.5, h = 200*CuffScale, center=true, $fn=30);
                
            }
        }
        
        if(LeatherOrPlastic == "Leather") {
        //cut ShellThickness off the bottom of entire part. For this leather version the leather itself willadd that back on.
            translate([0,-BicepCircumferenceWPadding/2 , -1])cube([ CuffLength *2, BicepCircumferenceWPadding*2, ShellThickness + 1]);
        }

    }

    // fill in over slots for straps with a new rounded cover
    hull() {
        rotate(a=[90,-90,-90]) translate([10.5,3.75, -CuffScale  * 49 -CuffLength/2 - (StrapWidth + 3) /2])cylinder(d=3, h=StrapWidth + 3);
        rotate(a=[90,-90,-90]) translate([10.5,-3.75, -CuffScale  * 49 -CuffLength/2 - (StrapWidth + 3) /2])cylinder(d=3, h=StrapWidth + 3);
        
        //rotate(a=[90,-90,-90]) translate([9.5,3.5, -CuffScale  * 49 -CuffLength/2 - (StrapWidth + 3) /2])cylinder(d=4, h=StrapWidth + 3);
        //rotate(a=[90,-90,-90]) translate([9.5,-3.5, -CuffScale  * 49 -CuffLength/2 - (StrapWidth + 3) /2])cylinder(d=4, h=StrapWidth + 3);
    }
}


//***************************
// MakeCuffFlap() 
//***************************
module MakeCuffFlap( CuffWidth, CuffYoffset) {
    
    difference() {
        union() {//91.5
        translate([CuffScale  * 49, CuffYoffset , 0 ])
             difference() {
                 union() {
                // the plate with slots
                difference() {
                    translate([0, 0 , 0 ]) cube([ CuffLength, CuffWidth, ShellThickness]);
                    

                    MakeCuffslots1();
                }

                //solid on end
                translate([0, 0 , 0 ])cube([ CuffLength, 3*CuffScale, ShellThickness]);

                //lip on leading edge to glue on other stiffener
                translate([0, BicepCircumferenceWPadding/2 -CuffYoffset - 5.5*CuffScale, 0 ])cube([ CuffLength, 5.25*CuffScale , ShellThickness]);
                translate([CuffLength, BicepCircumferenceWPadding/2 -CuffYoffset  - 1.25*CuffScale, ShellThickness ])
                rotate(a=[90,-90,-90]) linear_extrude(CuffLength)
                    polygon(points=[[0,-1*CuffScale],[3*CuffScale,0],[0,1*CuffScale]], paths=[[0,1,2]]);
                    
                     
 
            }
            

            //Cut angle off glueable triangle end
            translate([CuffLength-  7*CuffScale, BicepCircumferenceWPadding/2 -CuffYoffset - 8.5*CuffScale- CuffScale * 0.25 , ShellThickness+ 7*CuffScale ])rotate(a=[0,45,0])cube([ CuffScale*10, CuffScale*10 , CuffScale*10]);
            
        }
    }
       
        //slots for strap
    //translate([CuffScale  * 49 +CuffLength/2 - (StrapWidth + 1) /2,+ BicepCircumferenceWPadding/2 -7*CuffScale  , ShellThickness-8 ])cube([ StrapWidth + 1, 14*CuffScale, 30*ShellThickness]);
        
    }
   

}

//***************************
// MakeCuffLeatherTemplate() 
//***************************
module MakeCuffLeatherTemplate() {
    
    if(LeatherOrPlastic == "Leather") {
        
        // the outline of the whole cuff
        polygonpoints = [[0,-2*BicepCircumferenceWPadding/6],[CuffLength,-2*BicepCircumferenceWPadding/6],[CuffLength,5*BicepCircumferenceWPadding/6],[0,5*BicepCircumferenceWPadding/6]];
      
      difference() {  
        polygon(polygonpoints, paths=[[0,1,2,3]]);
        
        //circles for the four holes for the leather rivets to go through
        translate([CuffLength/5 , 0  ])
        circle(d=RivetShaftDiameter + 0.5, $fn=30);
        
        translate([4*CuffLength/5, 0])
        circle(d=RivetShaftDiameter + 0.5, $fn=30);
        
        translate([CuffLength/5 , BicepCircumferenceWPadding/2])
        circle(d=RivetShaftDiameter + 0.5, $fn=30);
        
        translate([4*CuffLength/5, BicepCircumferenceWPadding/2])
        circle(d=RivetShaftDiameter + 0.5, $fn=30);
          
          echo(" far hole", 4*CuffLength/5);
      }
        
    }
}

//***************************
// MakeCuff1() 
//***************************
module MakeCuff1() {
    
     offset = max(-12 *ElbowPartsScale + ArmShellThickness,  - (  BicepDiameterWPadding- ForearmDiameterWPadding)/2-13 *ElbowPartsScale + ArmShellThickness +12);
        
    MakeCuffBase(1, BicepCircumferenceWPadding/2  - CuffScale * 0.25, 0, offset, 20.5);

}

//***************************
// MakeCuff2() 
//***************************
module MakeCuff2() {
    
    offset = max(-12 *ElbowPartsScale + ArmShellThickness,  - (  BicepDiameterWPadding- ForearmDiameterWPadding)/2-13 *ElbowPartsScale + ArmShellThickness +12);
  
    MakeCuffBase(2, BicepCircumferenceWPadding/2 - CuffScale * 8.5 - CuffScale * 4, CuffScale  * -5.5, offset, 7.5);

}

//***************************
// MakeCuff3() 
//***************************
module MakeCuff3() {
    
    if(LeatherOrPlastic != "Leather")
        MakeCuffFlap( BicepCircumferenceWPadding/4 - CuffScale * 5.75, BicepCircumferenceWPadding/4 + CuffScale  * 5.5 );

}



//***************************
// MakeCuff1Imports() 
//***************************
module MakeCuff1Imports() {
    
    offset1 = max(-12*ElbowPartsScale + ArmShellThickness,  - (  BicepDiameterWPadding- ForearmDiameterWPadding)/2-13 *ElbowPartsScale + ArmShellThickness  +12)+22.5;

    
    translate([25*ElbowPartsScale - 1*ElbowPartsScale - 60*ElbowPartsScale -20,(14*ElbowPartsScale)/2 - 1*ElbowPartsScale - 5.5*ElbowPartsScale-.5*ElbowPartsScale, offset1+11*ElbowPartsScale + 1*ElbowPartsScale])
    Cuff1();
        
}

//***************************
// MakeCuff2Imports() 
//***************************
module MakeCuff2Imports() {

    
    offset2 = max(-12 *ElbowPartsScale + ArmShellThickness,  - (  BicepDiameterWPadding- ForearmDiameterWPadding)/2-13 *ElbowPartsScale + ArmShellThickness  +12);
 
    
    translate([25*ElbowPartsScale - 1*ElbowPartsScale - 60*ElbowPartsScale -20,(14*ElbowPartsScale)/2 - 1*ElbowPartsScale - 5.5*ElbowPartsScale-.5*ElbowPartsScale, offset2+11*ElbowPartsScale + 1*ElbowPartsScale])
        rotate([0,0,180]) Cuff2();

}



//--pitch-----------------------------------------------------------------------
// function for ISO coarse thread pitch (these are specified by ISO)
function get_coarse_pitch(dia) = lookup(dia, [
[1,0.25],[1.2,0.25],[1.4,0.3],[1.6,0.35],[1.8,0.35],[2,0.4],[2.5,0.45],[3,0.5],[3.5,0.6],[4,0.7],[5,0.8],[6,1],[7,1],[8,1.25],[10,1.5],[12,1.75],[14,2],[16,2],[18,2.5],[20,2.5],[22,2.5],[24,3],[27,3],[30,3.5],[33,3.5],[36,4],[39,4],[42,4.5],[45,4.5],[48,5],[52,5],[56,5.5],[60,5.5],[64,6],[78,5]]);


module make_bolt(dia,hi, headhi, headDiameter)
// make an ISO bolt 
//  dia=diameter, 6=M6 etc.
//  hi=length of threaded part of bolt
{
//rotate for better print orientation
rotate([-90,0,0]) 
    difference() {
        union()
        {   
            difference() {
            cylinder(d = headDiameter, h = headhi, $fn=30);
            
                // Make head rounded
                difference() {
                    
                    pad = 0.1; // Padding to maintain manifold
                    r = 1; // radius of fillet
                    cr = headDiameter/2;
                        
                    rotate_extrude(convexity=10, $fn = 30) translate([cr-r+pad, -pad, 0]) square(r+pad,r+pad);
                    rotate_extrude(convexity=10, $fn = 30) translate([cr-r, r, 0]) circle(r=r,$fn=30);
                    }
       
            }
            translate([0,0,headhi-0.1]) thread_out_centre(dia,hi+0.1);
            translate([0,0,headhi-0.1]) thread_out(dia,hi+0.1);
        }
        
        // make the hex hole
        translate([0,0,-1]) rotate([0,0,45]) cylinder(d = dia - 2 ,h = dia, $fn=4);
     
        //flatten one side to make it printable
        translate([-hi, dia/2 - dia/12, -1]) cube(hi *2);   
        
        //flatten other side to make threads not wavy on top
        translate([-hi,- (hi *2) - (dia/2 - dia/14), headhi + 0.1]) cube(hi *2);   
    }
    
         
}

module thread_out(dia,hi,thr=$fn)
// make an outside ISO thread (as used on a bolt)
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
	//JB: I add this mirror because the model will be mirrored at the end if it is a left
    if (LeftRight == "Left") {
            mirror([0,1,0])thread_out_pitch(dia,hi,p,thr);
        } else
        thread_out_pitch(dia,hi,p,thr);
}

module thread_in(dia,hi,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	p = get_coarse_pitch(dia);
    //JB: I add this mirror because the model will be mirrored at the end if it is a left
    if (LeftRight == "Left") {
            mirror([0,1,0]) thread_in_pitch(dia,hi,p,thr); 
    } else
            thread_in_pitch(dia,hi,p,thr);  
}

module thread_out_pitch(dia,hi,p,thr=$fn)
// make an outside thread (as used on a bolt) with supplied pitch
//  dia=diameter, 6=M6 etc
//  hi=height, 10=make a 10mm long thread
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of full turns
	n=r/(p/thr);			// number of segments for remainder
	// do full turns
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_out_turn(dia,p,thr);
	// do remainder
	for(sg=[0:n])
		th_out_pt(Rmin-0.1,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_in_pitch(dia,hi,p,thr=$fn)
// make an inside thread (as used on a nut)
//  dia = diameter, 6=M6 etc
//  hi = height, 10=make a 10mm long thread
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h=(cos(30)*p)/8;
	Rmin=(dia/2)-(5*h);	// as wiki Dmin
	s=360/thr;				// length of segment in degrees
	t1=(hi-p)/p;			// number of full turns
	r=t1%1.0;				// length remaining (not full turn)
	t=t1-r;					// integer number of turns
	n=r/(p/thr);			// number of segments for remainder
	for(tn=[0:t-1])
		translate([0,0,tn*p])	th_in_turn(dia,p,thr);
	for(sg=[0:n])
		th_in_pt(Rmin,p,s,sg+(t*thr),thr,h,p/thr);
}

module thread_out_centre(dia,hi)
{
	p = get_coarse_pitch(dia);
	thread_out_centre_pitch(dia,hi,p);
}

module thread_out_centre_pitch(dia,hi,p)
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin

	cylinder(r = Rmin, h = hi);
}

module thread_in_ring(dia,hi,thk)
{
	difference()
	{
		cylinder(d = dia,h = hi);
		translate([0,0,-1]) cylinder(d = dia - thk*2, h = hi + 1);
	}
}

//--low level bolt modules-----------------------------------------------------------

module th_out_turn(dia,p,thr=$fn)
// make a single turn of an outside thread
//  dia=diameter, 6=M6 etc
//  p=pitch
//  thr=thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_out_pt(Rmin-0.1,p,s,sg,thr,h,p/thr);
}

module th_out_pt(rt,p,s,sg,thr,h,sh)
// make a part of an outside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = (sg % thr) * s ;			// angle to start of seg
	ae = as + s  - (s/100) + 0.2;		// angle to end of seg (with overlap) JB: The 0.2 makes the segments link
	z = sh*sg;
	//pp = p/2;
	//   1,4
	//   |\
	//   | \  2,5
 	//   | / 
	//   |/
	//   0,3
	//  view from front (x & z) extruded in y by sg
	//  
	//echo(str("as=",as,", ae=",ae," z=",z));
	polyhedron(
		points = [
			[cos(as)*rt,sin(as)*rt,z],								// 0
			[cos(as)*rt,sin(as)*rt,z+(3/4*p)],						// 1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/8*p)],		// 2
			[cos(ae)*rt,sin(ae)*rt,z+sh],							// 3
			[cos(ae)*rt,sin(ae)*rt,z+(3/4*p)+sh],					// 4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh+(3/8*p)]],	// 5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}

module th_in_turn(dia,p,thr=$fn)
// make an single turn of an inside thread
//  dia = diameter, 6=M6 etc
//  p=pitch
//  thr = thread quality, 10=make a thread with 10 segments per turn
{
	h = (cos(30)*p)/8;
	Rmin = (dia/2) - (5*h);	// as wiki Dmin
	s = 360/thr;
	for(sg=[0:thr-1])
		th_in_pt(Rmin,p,s,sg,thr,h,p/thr);
}

module th_in_pt(rt,p,s,sg,thr,h,sh)
// make a part of an inside thread (single segment)
//  rt = radius of thread (nearest centre)
//  p = pitch
//  s = segment length (degrees)
//  sg = segment number
//  thr = segments in circumference
//  h = ISO h of thread / 8
//  sh = segment height (z)
{
	as = ((sg % thr) * s - 180);	// angle to start of seg
	ae = as + s -(s/100) + 0.2;		// angle to end of seg (with overlap) JB: The 0.2 makes the segments link
	z = sh*sg;
	pp = p/2;
	//         2,5
	//          /|
	//     1,4 / | 
 	//         \ |
	//          \|
	//         0,3
	//  view from front (x & z) extruded in y by sg
	//  
	polyhedron(
		points = [
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z],				//0
			[cos(as)*rt,sin(as)*rt,z+(3/8*p)],						//1
			[cos(as)*(rt+(5*h)),sin(as)*(rt+(5*h)),z+(3/4*p)],		//2
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+sh],			//3
			[cos(ae)*rt,sin(ae)*rt,z+(3/8*p)+sh],					//4
			[cos(ae)*(rt+(5*h)),sin(ae)*(rt+(5*h)),z+(3/4*p)+sh]],	//5
		faces = [
			[0,1,2],			// near face
			[3,5,4],			// far face
			[0,3,4],[0,4,1],	// left face
			[0,5,3],[0,2,5],	// bottom face
			[1,4,5],[1,5,2]]);	// top face
}


/* ==========================
 The Interpolation and path smoothing code is from Timothy Weber
https://github.com/teejaydub/tjw-scad
*/

// ==================================================================
// Interpolation and path smoothing

// Takes a path of points (any dimensionality),
// and inserts additional points between the points to smooth it.
// Repeats that n times, and returns the result.
// If loop is true, connects the end of the path to the beginning.
function smooth(path, n, loop=false) =
  n == 0
    ? path
    : loop
      ? smooth(subdivide_loop(path), n-1, true)
      : smooth(subdivide(path), n-1, false);

// Takes an open-ended path of points (any dimensionality), 
// and subdivides the interval between each pair of points from i to the end.
// Returns the new path.
function subdivide(path) =
  let(n = len(path))
  flatten(concat([for (i = [0 : 1 : n-1])
    i < n-1? 
      // Emit the current point and the one halfway between current and next.
      [path[i], interpolateOpen(path, n, i)]
    :
      // We're at the end, so just emit the last point.
      [path[i]]
  ]));

// Takes a closed loop points (any dimensionality), 
// and subdivides the interval between each pair of points from i to the end.
// Returns the new path.
function subdivide_loop(path, i=0) = 
  let(n = len(path))
  flatten(concat([for (i = [0 : 1 : n-1])
    [path[i], interpolateClosed(path, n, i)]
  ]));

weight = [-1, 8, 8, -1] / 14;
weight0 = [6, 11, -1] / 16;
weight2 = [1, 1] / 2;

// Interpolate on an open-ended path, with discontinuity at start and end.
// Returns a point between points i and i+1, weighted.
function interpolateOpen(path, n, i) =
  i == 0? 
    n == 2?
      path[i]     * weight2[0] +
      path[i + 1] * weight2[1]
    :
      path[i]     * weight0[0] +
      path[i + 1] * weight0[1] +
      path[i + 2] * weight0[2]
  : i < n - 2?
    path[i - 1] * weight[0] +
    path[i]     * weight[1] +
    path[i + 1] * weight[2] +
    path[i + 2] * weight[3]
  : i < n - 1?
    path[i - 1] * weight0[2] +
    path[i]     * weight0[1] +
    path[i + 1] * weight0[0]
  : 
    path[i];

// Use this to interpolate for a closed loop.
function interpolateClosed(path, n, i) =
  path[(i + n - 1) % n] * weight[0] +
  path[i]               * weight[1] +
  path[(i + 1) % n]     * weight[2] +
  path[(i + 2) % n]     * weight[3] ;
  
// Given a three-dimensional array of points (or a list of lists of points),
// return a single-dimensional vector with all the data.
function flatten(list) = [ for (i = list, v = i) v ]; 


module Palm() {scale([HandScale,HandScale,HandScale]) import("o_Palm.stl", convexity=3);}


module PalmCutTool() {scale([HandScale,HandScale,HandScale]) import("o_PalmCutTool.stl", convexity=3);}

module PencilHolderTool() {scale([HandScale,HandScale,HandScale]) import("o_PencilHolderTool.stl", convexity=3);}

module PalmTop() {scale([HandScale,HandScale,HandScale]) import("o_PalmTop.stl", convexity=3);}

module IndexFingerEnd() {rotate(a=[75,0,0])scale([HandScale,HandScale,HandScale]) import("o_IndexFingerEnd.stl", convexity=3);}

module IndexFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_IndexFingerPhalanx.stl", convexity=3);}

module MiddleFingerEnd() {rotate(a=[95,0,0])scale([HandScale,HandScale,HandScale]) import("o_MiddleFingerEnd.stl", convexity=3);}

module MiddleFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_MiddleFingerPhalanx.stl", convexity=3);}

module PinkyFingerEnd() {rotate(a=[90,0,0])scale([HandScale,HandScale,HandScale]) import("o_PinkyFingerEnd.stl", convexity=3);}

module PinkyFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_PinkyFingerPhalanx.stl", convexity=3);}

module RingFingerEnd() {rotate(a=[85,0,0])scale([HandScale,HandScale,HandScale]) import("o_RingFingerEnd.stl", convexity=3);}

module RingFingerPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_RingFingerPhalanx.stl", convexity=3);}

module ThumbEnd() {rotate(a=[-95,0,0])scale([HandScale,HandScale,HandScale]) import("o_ThumbEnd.stl", convexity=3);}

module ThumbPhalanx() {scale([HandScale,HandScale,HandScale]) import("o_ThumbPhalanx.stl", convexity=3);}

module WhippleTreePrimary() {scale([HandScale,1.0,1.0]) import("o_WhippleTreePrimary.stl", convexity=3);}

module WhippleTreeSecondary() {scale([HandScale,1.0,1.0]) import("o_WhippleTreeSecondary.stl", convexity=3);}

module MakeEATensionerLever() { import("o_EATensionerLever.stl", convexity=3); }

module MakeEATensionerHold(){ import("o_EATensionerHold.stl", convexity=3); }

module MakeSATensionerHold(){ import("o_SATensionerHold.stl", convexity=3); }

module MakeRatchet() {import("o_Ratchet.stl", convexity=3); }

module Cuff2Hub() {import("o_Cuff2Hub.stl", convexity=3); }

module GraspLatchBase() {import("o_GraspLatchBase.stl", convexity=3); }

module MakeLatchProbe() {import("o_GraspLatchProbe.stl", convexity=3); }

module TensionerProbe() {import("o_TensionerProbe.stl", convexity=3); }

module Cuff1() { import("o_Cuff1.stl", convexity=3); }

module Cuff2(){ import("o_Cuff2.stl", convexity=3); }

module VentingHoles11() {rotate(a = [0,0,-12])scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmLengthScale]) import("o_VentHoles11.stl", convexity=3); }

module VentingHoles12() {scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmLengthScale]) import("o_VentHoles12.stl", convexity=3); }

module VentingHoles21() {scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmLengthScale]) import("o_VentHoles21.stl", convexity=3); }

module VentingHoles22() {scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmLengthScale]) import("o_VentHoles22.stl", convexity=3); }

module VentingHoles31() {rotate(a = [0,0,4])scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmLengthScale]) import("o_VentHoles31.stl", convexity=3); }

module VentingHoles32() {scale([ForeArmCircumferenceScale,ForeArmCircumferenceScale,ArmLengthScale]) import("o_VentHoles32.stl", convexity=3); }



