document.addEventListener("DOMContentLoaded", () => {
  const input = `519,81 -> 524,81
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
499,53 -> 499,57 -> 491,57 -> 491,63 -> 513,63 -> 513,57 -> 505,57 -> 505,53
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
540,132 -> 540,133 -> 552,133 -> 552,132
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
547,139 -> 552,139
558,142 -> 563,142
501,24 -> 505,24
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
551,142 -> 556,142
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
512,66 -> 512,70 -> 505,70 -> 505,78 -> 521,78 -> 521,70 -> 516,70 -> 516,66
551,164 -> 551,168 -> 546,168 -> 546,171 -> 556,171 -> 556,168 -> 555,168 -> 555,164
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
507,20 -> 511,20
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
545,148 -> 550,148
522,104 -> 526,104
499,53 -> 499,57 -> 491,57 -> 491,63 -> 513,63 -> 513,57 -> 505,57 -> 505,53
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
517,90 -> 522,90
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
538,148 -> 543,148
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
548,145 -> 553,145
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
514,93 -> 514,97 -> 506,97 -> 506,101 -> 523,101 -> 523,97 -> 518,97 -> 518,93
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
528,108 -> 532,108
562,145 -> 567,145
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
514,93 -> 514,97 -> 506,97 -> 506,101 -> 523,101 -> 523,97 -> 518,97 -> 518,93
495,24 -> 499,24
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
541,116 -> 541,117 -> 549,117 -> 549,116
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
501,20 -> 505,20
512,66 -> 512,70 -> 505,70 -> 505,78 -> 521,78 -> 521,70 -> 516,70 -> 516,66
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
554,139 -> 559,139
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
541,116 -> 541,117 -> 549,117 -> 549,116
514,93 -> 514,97 -> 506,97 -> 506,101 -> 523,101 -> 523,97 -> 518,97 -> 518,93
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
552,148 -> 557,148
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
523,84 -> 528,84
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
540,132 -> 540,133 -> 552,133 -> 552,132
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
514,93 -> 514,97 -> 506,97 -> 506,101 -> 523,101 -> 523,97 -> 518,97 -> 518,93
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
499,53 -> 499,57 -> 491,57 -> 491,63 -> 513,63 -> 513,57 -> 505,57 -> 505,53
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
540,132 -> 540,133 -> 552,133 -> 552,132
524,90 -> 529,90
544,142 -> 549,142
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
559,148 -> 564,148
499,53 -> 499,57 -> 491,57 -> 491,63 -> 513,63 -> 513,57 -> 505,57 -> 505,53
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
507,24 -> 511,24
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
499,53 -> 499,57 -> 491,57 -> 491,63 -> 513,63 -> 513,57 -> 505,57 -> 505,53
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
499,53 -> 499,57 -> 491,57 -> 491,63 -> 513,63 -> 513,57 -> 505,57 -> 505,53
512,66 -> 512,70 -> 505,70 -> 505,78 -> 521,78 -> 521,70 -> 516,70 -> 516,66
498,22 -> 502,22
525,106 -> 529,106
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
551,164 -> 551,168 -> 546,168 -> 546,171 -> 556,171 -> 556,168 -> 555,168 -> 555,164
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
512,66 -> 512,70 -> 505,70 -> 505,78 -> 521,78 -> 521,70 -> 516,70 -> 516,66
510,90 -> 515,90
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
514,93 -> 514,97 -> 506,97 -> 506,101 -> 523,101 -> 523,97 -> 518,97 -> 518,93
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
494,14 -> 494,15 -> 505,15 -> 505,14
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
551,164 -> 551,168 -> 546,168 -> 546,171 -> 556,171 -> 556,168 -> 555,168 -> 555,164
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
551,164 -> 551,168 -> 546,168 -> 546,171 -> 556,171 -> 556,168 -> 555,168 -> 555,164
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
555,145 -> 560,145
551,164 -> 551,168 -> 546,168 -> 546,171 -> 556,171 -> 556,168 -> 555,168 -> 555,164
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
494,14 -> 494,15 -> 505,15 -> 505,14
522,108 -> 526,108
494,14 -> 494,15 -> 505,15 -> 505,14
514,93 -> 514,97 -> 506,97 -> 506,101 -> 523,101 -> 523,97 -> 518,97 -> 518,93
504,18 -> 508,18
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
551,164 -> 551,168 -> 546,168 -> 546,171 -> 556,171 -> 556,168 -> 555,168 -> 555,164
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
512,66 -> 512,70 -> 505,70 -> 505,78 -> 521,78 -> 521,70 -> 516,70 -> 516,66
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
519,106 -> 523,106
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
510,22 -> 514,22
513,24 -> 517,24
495,50 -> 495,40 -> 495,50 -> 497,50 -> 497,43 -> 497,50 -> 499,50 -> 499,43 -> 499,50 -> 501,50 -> 501,41 -> 501,50
499,53 -> 499,57 -> 491,57 -> 491,63 -> 513,63 -> 513,57 -> 505,57 -> 505,53
527,87 -> 532,87
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
514,93 -> 514,97 -> 506,97 -> 506,101 -> 523,101 -> 523,97 -> 518,97 -> 518,93
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
531,90 -> 536,90
504,22 -> 508,22
520,87 -> 525,87
530,130 -> 530,123 -> 530,130 -> 532,130 -> 532,126 -> 532,130 -> 534,130 -> 534,128 -> 534,130 -> 536,130 -> 536,123 -> 536,130 -> 538,130 -> 538,124 -> 538,130 -> 540,130 -> 540,126 -> 540,130 -> 542,130 -> 542,122 -> 542,130 -> 544,130 -> 544,127 -> 544,130 -> 546,130 -> 546,125 -> 546,130 -> 548,130 -> 548,125 -> 548,130
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
550,136 -> 555,136
528,112 -> 542,112
516,84 -> 521,84
516,108 -> 520,108
541,145 -> 546,145
541,116 -> 541,117 -> 549,117 -> 549,116
534,161 -> 534,157 -> 534,161 -> 536,161 -> 536,154 -> 536,161 -> 538,161 -> 538,156 -> 538,161 -> 540,161 -> 540,153 -> 540,161 -> 542,161 -> 542,151 -> 542,161 -> 544,161 -> 544,160 -> 544,161 -> 546,161 -> 546,156 -> 546,161 -> 548,161 -> 548,159 -> 548,161 -> 550,161 -> 550,159 -> 550,161 -> 552,161 -> 552,159 -> 552,161
551,164 -> 551,168 -> 546,168 -> 546,171 -> 556,171 -> 556,168 -> 555,168 -> 555,164
512,66 -> 512,70 -> 505,70 -> 505,78 -> 521,78 -> 521,70 -> 516,70 -> 516,66
513,87 -> 518,87
512,66 -> 512,70 -> 505,70 -> 505,78 -> 521,78 -> 521,70 -> 516,70 -> 516,66
486,37 -> 486,34 -> 486,37 -> 488,37 -> 488,34 -> 488,37 -> 490,37 -> 490,28 -> 490,37 -> 492,37 -> 492,28 -> 492,37 -> 494,37 -> 494,30 -> 494,37 -> 496,37 -> 496,36 -> 496,37 -> 498,37 -> 498,36 -> 498,37
566,148 -> 571,148`

  let minx = Infinity;
  let miny = 0;
  let maxx = -Infinity;
  let maxy = -Infinity;

  const paths = input.split("\n").map(line => {
    const points = line.split(" -> ").map(point => {
      const [x, y] = point.split(",").map(s => parseInt(s));

      if(x < minx) minx = x;
      if(y < miny) miny = y;
      if(x > maxx) maxx = x;
      if(y > maxy) maxy = y;

      return [x, y];
    });

    const path = [];

    for(let i=1; i<points.length; i++) {
      path.push([points[i-1], points[i]]);
    }

    return path;
  });

  const Grid = function() {
    const bricks = new Set();
    const grainsOfSand = new Set();

    paths.forEach(path => {
      path.forEach(([[x1, y1], [x2, y2]]) => {
        const dx = Math.sign(x2 - x1);
        const dy = Math.sign(y2 - y1);

        bricks.add([x1, y1].toString());
        while(x1 !== x2 || y1 !== y2) {
          x1 += dx;
          y1 += dy;

          bricks.add([x1, y1].toString());
        }
      });
    });

    this.bricks = bricks;
    this.grainsOfSand = grainsOfSand;
  }

  Grid.prototype.isOutOfBounds = function(x, y) {
    if(x < minx) return true;
    if(y < miny) return true;
    if(x > maxx) return true;
    if(y > maxy) return true;

    return false;
  }

  Grid.prototype.isEmpty = function(x, y) {
    if(this.isOutOfBounds(x, y)) return false;
    if(this.bricks.has([x, y].toString())) return false;
    if(this.grainsOfSand.has([x, y].toString())) return false;

    return true;
  }

  const grid = new Grid();

  let part1 = 0;
  let done = false;
  let sandX = 500;
  let sandY = 0;

  const canvas = document.getElementById("canvas");
  const ctx = canvas.getContext("2d");

  update = () => {
    if(grid.isOutOfBounds(sandX, sandY+1)) {
      done = true;
      console.log('part1', part1);
    }

    if(grid.isEmpty(sandX, sandY+1)) {
      sandY++;
    } else if(grid.isEmpty(sandX-1, sandY+1)) {
      sandX--;
      sandY++;
    } else if(grid.isEmpty(sandX+1, sandY+1)) {
      sandX++;
      sandY++;
    } else {
      part1++;
      grid.grainsOfSand.add([sandX, sandY].toString());
      sandX = 500;
      sandY = 0;
    }
  }

  draw = () => {
    ctx.fillStyle = "skyblue";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = "maroon";
    grid.bricks.forEach(brick => {
      const [x, y] = brick.split(",").map(s => parseInt(s));
      ctx.fillRect(x*3-1350, y*3, 3, 3);
    });

    ctx.fillStyle = "#C2B280";

    ctx.beginPath();
    ctx.arc(sandX*3+1-1350, sandY*3+1, 1, 0, 2 + Math.PI)
    ctx.fill();

    grid.grainsOfSand.forEach(grainOfSand => {
      const [x, y] = grainOfSand.split(",").map(s => parseInt(s));

      ctx.beginPath();
      ctx.arc(x*3+1-1350, y*3+1, 1, 0, 2 + Math.PI)
      ctx.fill();
    });
  }

  loop = () => {
    for(let i=0; i<100; i++) {
      if(done) break;
      update();
    }
    draw();

    if(!done) {
      requestAnimationFrame(loop);
    }
  }

  loop();
}, false);
