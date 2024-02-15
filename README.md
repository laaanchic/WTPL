# WTPL
The Within Trial Phase Lock analysis (WTPL) measures the rhythmicity of electrophysiological signals at specific time points and frequencies. 
WTPL works by calculating the average phase difference between the signal at each time point and a family of time-points before and after it, defined by the user in units of cycles.

The algorithm is described in:
Karvat, G., Ofir, N., & Landau, A. N. (2023). [Sensory Drive Modifies Brain Dynamics and the Temporal Integration Window. Journal of Cognitive Neuroscience, 1–18.] (https://doi.org/10.1162/jocn_a_02088)

% This script provides an example of calculation of the Within-Trial Phase
% Locking (WTPL) as presented in Karvat, Ofir, & Landau, JOCN (2023).
% The input is the preprocessed EEG, divided into trials and in a "raw"
% structure according to the Fieldtrip conventions (the toolbox fieldtrip is 
% freely available at https://www.fieldtriptoolbox.org/).
% 
% For the code to work,  the directories containing this script and
% associated functions, as well as Fieldtrip, should be in the Matlab path.
%
% Version 1.2. Written by Golan Karvat, 24/05/2023
