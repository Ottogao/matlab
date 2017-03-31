% FDSP toolbox functions
% Path ->  C:\MATLAB6p5p1\toolbox\fdsp\fdsp
%
%   AlterWindow    - AlterWindow is a mex file to effect a specified window
%   cover_01       - F_COVER: Draw FDSP cover photo of a comb filter transfer function
%   f_adc          - F_ADC: Perform N-bit analog-to-digital conversion
%   f_base2dec     - F_BASE2DEC: Convert a base d array to a decimal integer
%   f_bilin        - F_BILIN: Bilinear analog to digital filter transformation
%   f_block        - F_BLOCK: Draw a block using the current axes
%   f_blockconv    - F_BLOCKCONV: Perform fast linear block convolution of two signals
%   f_butter       - F_BUTTER: ODE file for Butterworth lowpass analog filter 
%   f_butters      - F_BUTTERS: Design lowpass analog Butterworth filter
%   f_butterz      - F_BUTTERZ: Design a Butterworth frequency-selective digital filter
%   f_caliper      - F_CALIPER: Measure coorinates on current plot using mouse
%   f_calmenu      - F_CALMENU: Set up caliper menu item
%   f_cascade      - F_CASCADE: Find cascade form digital filter realization
%   f_chebpoly     - F_CHEBPOLY: Evaluate Chebychev polynomial of first kind
%   f_cheby1s      - F_CHEBY1S: Design Chebyshev-I lowpass analog filter
%   f_cheby1z      - F_CHEBY1Z: Design a Chebyshev-I frequency-selective digital filter
%   f_cheby2s      - F_CHEBY2S: Design a Chebyshev-II lowpass analog filter
%   f_cheby2z      - F_CHEBY2Z: Design a Chebyshev-II frequency-selective digital filter
%   f_checkbox     - F_CHECKBOX: Create a check box control
%   f_circle       - F_CIRCLE: Draw a circle in current plot
%   f_cleanstring  - F_CLEANSTRING: Replace _ in string s with \_ so it can be printed in a 
%   f_clip         - F_CLIP: Clip a value, or a calling argument, to an interval
%   f_conv         - F_CONV: Fast linear or circular convolution
%   f_corr         - F_CORR: Fast cross-correlation of two discrete-time signals
%   f_corrlms      - F_CORRLMS: FIR system identification using correlation LMS method.
%   f_cover        - F_COVER: Draw FDSP cover photo of a comb filter transfer function
%   f_dac          - F_DAC: Perform N-bit digital to analog conversion
%   f_deadzone     - F_DEADZONE: Insert a dead zone interval
%   f_dec2base     - F_DEC2BASE: Convert a decimal integer to a base d array
%   f_decimate     - F_DECIMATE: Reduce sampling rate by factor M.
%   f_drawadapt    - F_DRAWADAPT: Draw a block diagram for GUI module g_adapt
%   f_drawcorr     - F_DRAWCORR: Draw a block diagram for GUI module g_correlate
%   f_drawfilt     - F_DRAWFILT: Draw a block diagram for GUI module g_filters
%   f_drawiir      - F_DRAWIIR: Draw a block diagram for GUI module g_iir
%   f_drawrate     - F_DRAWRATE: Draw a block diagram for GUI module g_multirate
%   f_drawrecon    - F_DRAWRECON: Draw a block diagram for GUI module g_reconstruct
%   f_drawsamp     - F_DRAWSAMP: Draw a block diagram for GUI module g_sample
%   f_drawspec     - F_DRAWSPEC: Draw a block diagram for GUI module g_spectra
%   f_drawsys      - F_DRAWSAMP: Draw a block diagram for GUI module g_sample
%   f_dsp          - F_DSP: Driver module for FDSP Toolbox
%   f_editbox      - F_EDITBOX: Create edit box
%   f_elliptics    - F_ELLIPTICS: Design elliptic lowpass analog filter
%   f_ellipticz    - F_ELLIPTICZ: Design elliptic frequency-selective digital filter
%   f_exitmenu     - F_EXITMENU: Create exit menu item
%   f_filtcas      - F_FILTCAS: Compute output of cascade form fitler realization
%   f_filter       - F_FILTER: Compute the zero-state response of the following filter
%   f_filtlat      - F_FILTLAT: Compute output of lattice form filter realization
%   f_filtpar      - F_FILTPAR: Compute output of parallel form filter realization
%   f_firamp       - F_FIRAMP: Compute amplitude response of frequency-selective filter
%   f_firideal     - F_FIRIDEAL Designs a linear-phase frequency-selective windowed FIR filter
%   f_firls        - F_FIRLS: Designs a linear-phase least-squares FIR filter
%   f_firmenu      - F_FIRMENU: Set up FIR filter design method menu
%   f_firparks     - F_FIRPARKS: Design a linear-phase Parks-McClellan equiripple FIR filter
%   f_firsamp      - F_FIRSAMP: Design a linear-phase frequency-sampled FIR filter
%   f_firwin       - F_FIRWIN: Design a linear-phase windowed FIR filter
%   f_freqs        - F_FREQS: Compute freqeuncy response of continuous-time system
%   f_freqsav      - F_FREQZ: Compute frequency response of a discrete-time system
%   f_freqz        - F_FREQZ: Compute frequency response of a discrete-time system
%   f_funx         - F_FUNX: Compute a selected input signal
%   f_fxlms        - F_FXLMS: Identify a discrete-time system using the filtered-x LMS method
%   f_getAs        - _GETAS: Estimate stopband attenuation in dB of a lowpass filter
%   f_getadapt     - F_GETADAPT: Compute input and desired output for GUM module G_ADAPT
%   f_getcorr      - F_GETCORR: Compute inputs for GUI module G_CORRELATE
%   f_getfilters   - F_GETFILTERS: Compute filter coefficients for GUI module G_FILTERS
%   f_getfir       - F_GETFIR: Compute FIR filter coefficients for GUI module G_FIR
%   f_getfun       - F_GETFUN: Prompt for the name of an M-file function and add to path
%   f_getiir       - F_GETIIR: Compute IIR filter coefficients for GUI module G_IIR
%   f_getmfile     - F_GETFUN: Prompt the user for the name of an M-file function
%   f_getrate      - F_GETRATE: Compute input and output for GUI module G_MULTIRATE
%   f_getsnd       - F_GETSOUND: Record sound from PC microphone
%   f_getsound     - F_GETSOUND: Record sound from PC microphone
%   f_getspec      - F_GETSPEC: Compute input for GUI module G_SPECTRA
%   f_getsys       - F_GETSYS: Compute input for GUI module G_SYSTEM
%   f_gridpoint    - F_GRIDPOINT: Find grid point in domain of F_RBF0
%   f_guifigure    - F_GUIFIGURE: Create figure window for specified GUI module
%   f_guihome      - F_GUIHOME: Create figure window for the homework builder module
%   f_helpmenu     - F_HELPMENU: Set up help menu item
%   f_identify     - F_IDENTIFY: Identify IIR model using least squares fit
%   f_iircomb      - F_IIRCOMB: Design an IIR comb filter
%   f_iirinv       - F_IIRINV: Design an IIR inverse comb filter
%   f_iirmenu      - F_IIRMENU: Set up IIR filter design prototype menu
%   f_iirnotch     - F_IIRNOTCH: Design an IIR notch filter
%   f_iirres       - F_IIRRES: Design an IIR resonator filter
%   f_impulse      - F_IMPULSE: Compute the impulse response of a discrete-time system
%   f_interpol     - F_INTERPOL: Increase sampling rate by factor L.
%   f_labels       - F_LABELS: Add title and axis labels to current plot 
%   f_lattice      - F_LATTICE: Find lattice form FIR filter realization 
%   f_leaklms      - F_LEAKLMS: System identificatoin using leaky LMS method
%   f_line         - F_LINE: Draw a line segment on current figure
%   f_lms          - F_LMS: System identification using least mean square (LMS) method
%   f_loadmenu     - F_SAVEMENU: Create load menu item
%   f_logo         - F_LOGO: Draw FDSP logo of a comb filter transfer function
%   f_low2bps      - F_LOW2BPS: Lowpas to bandpass analog frequency transformation
%   f_low2bss      - F_LOW2BSS: Lowpass to bandstop analog frequency transformations
%   f_low2highs    - F_LOW2HIGHS: Lowpass to highpass analog frequency transformation
%   f_low2lows     - F_LOW2LOWS: Lowpass to lowpass analog frequency transformation
%   f_minall       - F_MINALL: Factor IIR fitler into minimum-phase and allpass parts
%   f_neighbors    - F_NEIGHBORS: Find scalar indeces of vertices of local grid element
%   f_normlms      - F_NORMLMS: System identification using normalized LMS method
%   f_oldmat       - F_OLDMAT: Check to see if MATLAB version is too old
%   f_parallel     - F_PARALLEL: Find parallel form filter realization
%   f_pds          - F_PDS: Compute estimated power density spectrum
%   f_plotadapt    - F_PLOTADAPT: Plot the selected view for the GUI module G_ADAPT
%   f_plotcorr     - F_PLOTCORR: Plot selective view for GUI module G_CORRELATE
%   f_ploterase    - F_PLOTERASE: Erase the the plot area used by GUI modules
%   f_plotfilters  - F_PLOTFILTERS: Plot selected view for GUI module G_FILTERS
%   f_plotfir      - F_PLOTFIR: Plot selected view for GUI module G_FIR
%   f_plothome     - F_PLOTHOME: Draw the homework assignment in display window
%   f_plotiir      - F_PLOTIIR: Plot selected view for GUI module G_IIR
%   f_plotrate     - F_PLOTRATE: Plot selected view for GUI module G_MULTIRATE
%   f_plotrec      - F_PLOTREC: Plot selected view for GUI module G_RECONSTRUCT
%   f_plotsamp     - F_PLOTSAMP: Plot selective view for GUI module G_SAMPLE
%   f_plotspec     - F_PLOTSPEC: Plot selected view for GUI module G_SPECTRA
%   f_plotsys      - F_PLOTSYS: Plot selected view for GUI module G_SYSTEM
%   f_printmenu    - F_PRINTMENU: Create print menu item
%   f_problems     - F_PROBLEMS: Generate cell array containing FDSP homework problem data
%   f_probrange    - F_PROBRANGE: Find start and stop subscripts from problems within a specified section range.
%   f_prompt       - F_PROMPT: Prompt user for numerical input in specified range
%   f_pushbutton   - F_PUSHBUTTON: Create pushbutton control
%   f_pzplot       - F_PZPLOT: Construct plot showing transfer function poles and zeros
%   f_pzsurf       - F_PZSURF: Construct surface plot of transfer function magnitude
%   f_quant        - F_QUANT: Quantization operator
%   f_randg        - F_RANDG: Construct Gaussian random matrix
%   f_randinit     - F_RANDINIT: Initialize random number generator
%   f_randprob     - F_GENHOME: Create pushbutton for selecting a random set of homework problems
%   f_randu        - F_RANDU: Construct a uniformly distributed random matrix
%   f_rateconv     - F_RATECONV: Convert sampling rate by rational factor L/M.
%   f_rbf0         - F_RBF0: Compute output of zeroth order raised-cosine RBF network
%   f_rbf1         - F_RBF1: Compute output of first order raised-cosine RBF network
%   f_rbfg         - F_RBFCOS: Compute raised-cosine RBF function
%   f_rbfv         - F_RBFW: Identify a nonlinear system using first order RBF network
%   f_rbfw         - F_RBFW: Identify a nonlinear system using a zeroth order RBF network
%   f_realizemenu  - F_REALIZEMENU: Set up filter realization menu 
%   f_regreader    - F_REGREADER: Find the location of the Adobe Acrobat Reader and save it.
%   f_reverb       - F_REVERB: Compute output of reverberation filter
%   f_rls          - F_RLS: Identify system using recursive least squares (RLS) method
%   f_savemenu     - F_SAVEMENU: Create save menu item
%   f_secvalue     - F_SECVALUE: Convert the chapter-based section number to a numerical value
%   f_showbar      - F_SHOWBAR: Display the slider bar label for GUI modules
%   f_sigsyn       - F_SIGSYN: Active noise control using the signal synthesis method
%   f_slider       - F_SLIDER: Create slider bar for GUI modules
%   f_sortpoles    - F_SORTPOLES: Sort poles and zeros of transfer function
%   f_spec         - F_SPEC: Compute magnitude, phase, and power density spectra
%   f_specgram     - F_SPECGRAM: Compute spectrogram of a signal
%   f_state        - F_STATE: Construct the state vector from the past inputs and outputs
%   f_string       - F_STRING: Compute output of tunable plucked-string filter
%   f_subsignals   - F_SUBSIGNALS: Compute a matrix of bandlimited subsignals
%   f_tocol        - F_TOCOL: Convert to a column vector
%   f_torow        - F_TOROW: Convert to a row vector
%   f_typebuttons  - F_TYPEBUTTONS: Create radio buttons for type options
%   f_unscramble   - F_UNSCRAMBLE: Reorder FFT output to freqency range [-fs/2,fs/2]
%   f_vector       - F_VECTOR: Draw a vector on current plot
%   f_viewbuttons  - F_VIEWBUTTONS: Create radio buttons for viewing options
%   f_wait         - F_WAIT: Pause and wait for a key to be pressed
%   f_window       - F_WINDOW: Compute data window vector
%   f_windowmenu   - F_WINDOWMENU: Set up data window menu item
%   u_fir1         - U_FIR1: Example user file for GUI module G_FIR
%   u_reconstruct1 - U_RECONSTRUCT1: Example user file for GUI module G_RECONSTRUCT
%   u_sample1      - U_SAMPLE1: Example user file for GUI module G_SAMPLE
