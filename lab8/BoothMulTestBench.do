onerror {resume}
radix define States {
    "3'd0" "Init",
    "3'd1" "Load",
    "3'd2" "Check",
    "3'd3" "Add",
    "3'd4" "Sub",
    "3'd5" "Next",
    "3'd6" "More",
    "3'd7" "Done",
    -default unsigned
}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /BoothMulTestBench/W
add wave -noupdate -radix binary /BoothMulTestBench/Clock
add wave -noupdate -radix States -childformat {{{/BoothMulTestBench/BM/State[2]} -radix States} {{/BoothMulTestBench/BM/State[1]} -radix States} {{/BoothMulTestBench/BM/State[0]} -radix States}} -subitemconfig {{/BoothMulTestBench/BM/State[2]} {-height 15 -radix States} {/BoothMulTestBench/BM/State[1]} {-height 15 -radix States} {/BoothMulTestBench/BM/State[0]} {-height 15 -radix States}} /BoothMulTestBench/BM/State
add wave -noupdate -radix binary /BoothMulTestBench/Reset
add wave -noupdate /BoothMulTestBench/Start
add wave -noupdate -radix unsigned /BoothMulTestBench/BM/Counter
add wave -noupdate -radix decimal -childformat {{{/BoothMulTestBench/BM/PM[9]} -radix decimal} {{/BoothMulTestBench/BM/PM[8]} -radix decimal} {{/BoothMulTestBench/BM/PM[7]} -radix decimal} {{/BoothMulTestBench/BM/PM[6]} -radix decimal} {{/BoothMulTestBench/BM/PM[5]} -radix decimal} {{/BoothMulTestBench/BM/PM[4]} -radix decimal} {{/BoothMulTestBench/BM/PM[3]} -radix decimal} {{/BoothMulTestBench/BM/PM[2]} -radix decimal} {{/BoothMulTestBench/BM/PM[1]} -radix decimal} {{/BoothMulTestBench/BM/PM[0]} -radix decimal}} -subitemconfig {{/BoothMulTestBench/BM/PM[9]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[8]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[7]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[6]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[5]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[4]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[3]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[2]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[1]} {-height 15 -radix decimal} {/BoothMulTestBench/BM/PM[0]} {-height 15 -radix decimal}} /BoothMulTestBench/BM/PM
add wave -noupdate -radix decimal /BoothMulTestBench/BM/R
add wave -noupdate -radix binary /BoothMulTestBench/BM/AddSub1/ovf
add wave -noupdate -radix decimal /BoothMulTestBench/M
add wave -noupdate -radix decimal /BoothMulTestBench/Q
add wave -noupdate -radix decimal -childformat {{{/BoothMulTestBench/P[7]} -radix decimal} {{/BoothMulTestBench/P[6]} -radix decimal} {{/BoothMulTestBench/P[5]} -radix decimal} {{/BoothMulTestBench/P[4]} -radix decimal} {{/BoothMulTestBench/P[3]} -radix decimal} {{/BoothMulTestBench/P[2]} -radix decimal} {{/BoothMulTestBench/P[1]} -radix decimal} {{/BoothMulTestBench/P[0]} -radix decimal}} -subitemconfig {{/BoothMulTestBench/P[7]} {-height 15 -radix decimal} {/BoothMulTestBench/P[6]} {-height 15 -radix decimal} {/BoothMulTestBench/P[5]} {-height 15 -radix decimal} {/BoothMulTestBench/P[4]} {-height 15 -radix decimal} {/BoothMulTestBench/P[3]} {-height 15 -radix decimal} {/BoothMulTestBench/P[2]} {-height 15 -radix decimal} {/BoothMulTestBench/P[1]} {-height 15 -radix decimal} {/BoothMulTestBench/P[0]} {-height 15 -radix decimal}} /BoothMulTestBench/P
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {131100 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 362
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {97900 ps} {360500 ps}
