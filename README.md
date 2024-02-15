# WTPL
The Within Trial Phase Lock analysis (WTPL) measures the rhythmicity of electrophysiological signals at specific time points and frequencies. 
WTPL works by calculating the average phase difference between the signal at each time point and a family of time-points before and after it, defined by the user in units of cycles.

The algorithm is described in:
Karvat, G., Ofir, N., & Landau, A. N. (2023). [Sensory Drive Modifies Brain Dynamics and the Temporal Integration Window. Journal of Cognitive Neuroscience, 1–18. DOI: 10.1162/jocn_a_02088](https://doi.org/10.1162/jocn_a_02088). When using the code, please cite this paper. 


Files in this repository:

[WTPL_main](WTPL_main.m): provides an example of calculation of WTPL. When using this script, please update WTPL_path to the path in which the WTPL files are saved. Note, that in order to run this script the freely available toolbox [Fieldtrip](https://www.fieldtriptoolbox.org/) should also be on your matlab path. When using fieldtrip, please also cite [this paper](http://dx.doi.org/10.1155/2011/156869). 

[EEG](EEG.mat): preprocessed EEG, divided into trials and in a "raw" structure according to the Fieldtrip conventions.

[wtplComp.m](wtplComp.m): a matlab function taking a frequency structure (FREQ, output of ft_freqanalysis), timepoints of interest (toi),  

[RedBlueColorMap.m](RedBlueColorMap.m): created the colormap that was used in the original publication. 

% This script provides an example of calculation of the Within-Trial Phase
% Locking (WTPL) as presented in Karvat, Ofir, & Landau, JOCN (2023).
% The input is the preprocessed EEG, divided into trials and in a "raw"
% structure according to the Fieldtrip conventions (the toolbox fieldtrip is 
% freely available at https://www.fieldtriptoolbox.org/).
% 
% For the code to work,  the directories containing this script and
% associated functions, as well as Fieldtrip, should be in the Matlab path.
%
Originally deposited in Zenodo, 15/02/2024, DOI: 10.5281/zenodo.10664624
