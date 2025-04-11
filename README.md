# IBM_smoothhounds

Data and code in this folder allow to replicate the analyses described in the paper "Individual-Based Modelling to fine-tune management measures for commercial demersal sharks"

Instructions:
- `A1_startval_gen.m` generates a population of starting values for the calibration of the IBMs and saves them in the folder "sarting values"
- `A2_calibration.m` calibrates the four IBMs configurations at different starting points
- `A3_compare_res.m` compares the IBMs based on the results of the calibration; the metrics computed by this script are summarised in Table 2 and Table 3 of the paper; Figure 2 of the paper is also made by this code
- `A4_scenarios.m` simulates management scenarios using the best fitting model and makes Figure 3 of the paper
