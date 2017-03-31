function f_dsp         

% F_DSP: Driver module for FDSP Toolbox
%
% Usage: f_dsp
%
% Version: 1.0
%
% Description: 
%
%   This MATLAB software is a supplement to the text 
%   "Fundamentals of Digital Signal Processing Using 
%   MATLAB" by R. J. Schilling and S. L, Harris, 
%   Brooks/Cole: Pacific Grove, CA, 2005. It is 
%   designed to allow users to run the chapter GUI 
%   modules and MATLAB examples, reproduce text figures,
%   and display solutions to selected problems. It also
%   provides the user with online help with the GUI 
%   modules and toolbox functions.
%
% Menu options:
%
%   1. GUI modules
%   2. Examples
%   3. Figures
%   4. Problems
%   5. Help
%   6. Web
%   7. Exit
%
% GUI simulation modules:
%
%   g_sample      => signal sampling 
%   g_reconstruct => signal reconstruciton 
%   g_system      => discrete-time linear systems 
%   g_spectra     => spectral analysis of signals 
%   g_correlate   => signal correlation and convolution 
%   g_filters     => filter specifications and structures
%   g_fir         => FIR filter design 
%   g_multirate   => multirate signal processing 
%   g_iir         => IIR filter design 
%   g_adapt       => adaptive signal processing 
%
% Main program support functions:
%
%   f_caliper   => measure points on graph with crosshairs
%   f_clip      => clip value to an interval
%   f_getsnd    => record sound from a microphone
%   f_labels    => draw axis labels and title for plot
%   f_prompt    => prompt for a number in a specified range
%   f_randg     => Gaussian random matrix A
%   f_randu     => uniformly distributed random matrix A
%   f_version   => MATLAB and FDSP version numbers
%   f_wait      => display a message and pause 
%  
% Chapter 1: Signal processing functions:
%
%   f_adc       => analog-to-digital conversion
%   f_dac       => digital-to-analog conversion 
%   f_quant     => quantization operator
%   f_freqs     => continuous-time frequency response  
%
% Chapter 2: Discrete-time systems analysis functions:
%
%   f_freq      => exact discrete-time frequency response
%   f_impulse   => impulse response
%   f_pzplot    => pole-zero sketch
%   f_pzsurf    => plot transfer function magnitude surface
%   f_spec      => signal spectra 
%
% Chapter 3: The DFT and spectral analysis functions:
%
%   f_freqz      => discrete-time frequency response using DFT
%   f_pds        => estimated power density spectrum
%   f_specgram   => signal spectrogram
%   f_unscramble => convert FFT output to range [-fs/2,fs/2]
%   f_window     => data windows
%
% Chapter 4: Convolution and correlation functions:
%
%   f_conv      => fast linear and circular convolution
%   f_corr      => fast linear and circular correlation 
%   f_blockconv => fast linear block convolution 
%
% Chapter 5: Filter specifications and structures functions:
%
%   f_cascade  => find cascade form realization (IIR)
%   f_filtlat  => lattice form filter output (FIR)
%   f_filtcas  => cascade form filter output (IIR)
%   f_filtpar  => parallel form filter output (IIR)
%   f_lattice  => find lattice form realization (FIR)
%   f_minall   => minimum-phase decompostion (IIR)
%   f_parallel => find parallel form realization (IIR)
%   
% Chapter 6: FIR filter design functions:
%
%   f_firamp   => frequency-selective amplitude response
%   f_firideal => design basic windowed FIR filter
%   f_firls    => design least-squares FIR filter
%   f_firsamp  => design frequency-sampled FIR filter
%   f_firwin   => design custom windowed FIR filter
%   f_firparks => design Parks-McLellen equiripple FIR filter
%   
% Chapter 7: Multirate signal processing functions:
%
%   f_decimate => sampling rate converter
%   f_interpol => sampling rate converter
%   f_rateconv => sampling rate converter
%
% Chapter 8: IIR filter design functions:
%
%   f_bilin     => bilinear transformation IIR design
%   f_butterz   => design Butterworth digital filter
%   f_cheby1z   => design Chebyshev-I digital filter
%   f_cheby2z   => design Chebyshev-II digital filter
%   f_ellipticz => design elliptic digital filter
%   f_iircomb   => design IIR comb filter
%   f_iirinv    => design IIR inverse comb filter
%   f_iirnotch  => design IIR notch filter
%   f_iirres    => design IIR resonator filter
%   f_low2bps   => analog lowpass to bandpass transformation
%   f_low2bss   => analog lowpass to bandstop transformation
%   f_low2highs => analog lowpass to highpass transformation
%   f_low2lows  => analog lowpass to lowpass transformation
%   f_reverb    => reverb filter
%   f_string    => plucked string filter
%
% Chapter 9: Adaptive signal processing functions:
%
%   f_lms        => least mean square (LMS) method
%   f_normlms    => normalized LMS method
%   f_corrlms    => correlation LMS method
%   f_leaklms    => leaky LMS method
%   f_fxlms      => filtered-x LMS method
%   f_rls        => recursive least squares (RLS) method
%   f_sigsyn     => signal synthesis method
%   f_rbfw       => RBF network training algorithm
%   f_rbf0       => RBF network output (raised-cosine)
%   f_state      => state vector of discrete-time system
%
% See also: 
%           G_SAMPLE G_RECONSTRUCT G_SYSTEM G_SPECTRA
%           G_CORRELATE G_FILTERS G_FIR G_MULTIRATE G_IIR
%           G_ADAPT   
  
% Programming notes:

% 1. In MATLAB 7, the Quit option activates prematurely when scanned
%    from the left after a click.
% 2. In MATLAB 7, the first time helpwin is called, it goes to the
%    standard MATLAB help, not the file specified. 

% Check MATLAB version

clc
clear all
if f_oldmat;
   return
end

% Initialize

instructor = 0;                          % Separate CD needed for this!
fdsp_version = f_version('FDSP');
matlab_version = f_version('MATLAB');
num_chap = 9;

fdsp_guis = ...
[
'g_sample       g_sample     '
'g_reconstruct  g_reconstruct'
'g_system       g_system     '
'g_spectra      g_spectra    '
'g_correlate    g_correlate  '
'g_filters      g_filters    '
'g_fir          g_fir        '
'g_multirate    g_multirate  '
'g_iir          g_iir        ' 
'g_adapt        g_adapt      ' 
];
[num_guis,m] = size(fdsp_guis);
guis = fdsp_guis(:,1:13);

fdsp_exam = ...
[
'exam1_10 Example 1.10    Successive approximation              '
'exam1_12 Example 1.12    Anti-aliasing filter design           '
'                                                               '
'exam2_15 Example 2.15    Zero-state response                   ' 
'exam2_18 Example 2.18    Comb filter                           ' 
'exam2_20 Example 2.20    Impulse response                      ' 
'exam2_21 Example 2.21    Convolution                           ' 
'exam2_26 Example 2.26    Frequency response                    '
'exam2_27 Example 2.27    Steady-state response                 '
'exam2_28 Example 2.28    Home mortgage                         '
'exam2_29 Example 2.29    Satellite attitude control            '
'exam2_30 Example 2.30    The Fibonacci sequence                '
'                                                               '
'exam3_1  Example 3.1     Spectrum of causual exponential       ' 
'exam3_7  Example 3.7     Uniform white noise                   ' 
'exam3_8  Example 3.8     Gaussian white noise                  ' 
'exam3_9  Example 3.9     Discrete frequency response           ' 
'exam3_10 Example 3.10    Zero padding                          ' 
'exam3_11 Example 3.11    Frequency resolution                  ' 
'exam3_12 Example 3.12    Bartlett''s method: white noise        ' 
'exam3_13 Example 3.13    Bartlett''s method: periodic input     ' 
'exam3_14 Example 3.14    Welch''s method: noisy periodic input  ' 
'exam3_15 Example 3.15    Spectrogram                           ' 
'exam3_16 Example 3.16    Signal detection                      ' 
'exam3_17 Example 3.17    Distortion due to clipping            ' 
'                                                               '
'exam4_6  Example 4.6     Fast convolution                      ' 
'exam4_7  Example 4.7     Fast block convolution                ' 
'exam4_8  Example 4.8     Linear cross-correlation              ' 
'exam4_9  Example 4.9     Fast linear correlation               ' 
'exam4_10 Example 4.10    Power density spectrum                ' 
'exam4_11 Example 4.11    Period estimation                     ' 
'exam4_12 Example 4.12    Periodic signal extraction from noise ' 
'exam4_13 Example 4.13    Echo detection                        ' 
'exam4_14 Example 4.14    Speech analysis and pitch             ' 
'                                                               '
'exam5_1  Example 5.1     Linear design specifications          ' 
'exam5_2  Example 5.2     Logarithmic design specifications (dB)' 
'exam5_5  Example 5.5     Minimum-phase filter                  ' 
'exam5_6  Example 5.6     Minimum-phase decomposition           ' 
'exam5_7  Example 5.7     FIR cascade form                      ' 
'exam5_8  Example 5.8     FIR lattice form                      ' 
'exam5_9  Example 5.9     IIR parallel form                     ' 
'exam5_10 Example 5.10    IIR cascade form                      ' 
'exam5_11 Example 5.11    Input quantization noise              ' 
'exam5_12 Example 5.12    FIR coefficient quantization error    ' 
'exam5_13 Example 5.13    FIR overflow and scaling              ' 
'exam5_14 Example 5.14    IIR coefficient quantization          ' 
'exam5_15 Example 5.15    IIR overflow and scaling              ' 
'exam5_16 Example 5.16    Limit cycle                           ' 
'exam5_17 Example 5.17    Highpass elliptic filter              '
'                                                               ' 
'exam6_1  Example 6.1     Truncated impulse response filter     ' 
'exam6_2  Example 6.2     Windowed lowpass fitlers              ' 
'exam6_3  Example 6.3     Windowed bandpass filter              ' 
'exam6_4  Example 6.4     Frequency-sampled lowpass filter      ' 
'exam6_5  Example 6.5     Filter with transition band sample    ' 
'exam6_6  Example 6.6     Optimal transition band sample        ' 
'exam6_7  Example 6.7     Least-squares bandpass filter         ' 
'exam6_8  Example 6.8     Equiripple filter                     ' 
'exam6_9  Example 6.9     Differentiator                        ' 
'exam6_10 Example 6.10    Hilbert transformer                   ' 
'exam6_11 Example 6.11    FIR bandstop filter design            '
'                                                               '
'exam7_1  Example 7.1     Integer decimator                     ' 
'exam7_2  Example 7.2     Integer interpolator                  ' 
'exam7_3  Example 7.3     Rational sampling rate converter      ' 
'exam7_6  Example 7.6     Multirate narrowband filter           ' 
'exam7_7  Example 7.7     Signal synthesis                      ' 
'exam7_8  Example 7.8     Oversampling ADC                      ' 
'exam7_9  Example 7.9     Oversampling DAC                      ' 
'exam7_10 Example 7.10    CD-to-DAT sampling rate converter     ' 
'                                                               '
'exam8_1  Example 8.1     Resonator filter                      ' 
'exam8_2  Example 8.2     Notch filter                          ' 
'exam8_3  Example 8.3     Filter design parameters              ' 
'exam8_4  Example 8.4     Butterworth filter                    ' 
'exam8_5  Example 8.5     Butterworth transfer function         ' 
'exam8_6  Example 8.6     Chebyshev-I filter                    ' 
'exam8_7  Example 8.7     Elliptic filter                       ' 
'exam8_8  Example 8.8     Bilinear transformation method        ' 
'exam8_10 Example 8.10    Digital bandpass filter               ' 
'exam8_11 Example 8.11    Reverb filter                         ' 
'                                                               '
'exam9_1  Example 9.1     Optimal weight vector                 ' 
'exam9_3  Example 9.3     System identification                 ' 
'exam9_7  Example 9.7     Excess mean square error              ' 
'exam9_8  Example 9.8     Normalized LMS method                 ' 
'exam9_9  Example 9.9     Correlation LMS method                ' 
'exam9_10 Example 9.10    Leaky LMS method                      ' 
'exam9_11 Example 9.11    Adaptive FIR filter design            ' 
'exam9_12 Example 9.12    Adaptive linear-phase FIR filter      ' 
'exam9_13 Example 9.13    RLS method                            ' 
'exam9_14 Example 9.14    FXLMS method                          ' 
'exam9_15 Example 9.15    Signal-synthesis method               ' 
'exam9_17 Example 9.17    Raised-cosine RBF                     ' 
'exam9_18 Example 9.18    Constant interpolation property       ' 
'exam9_19 Example 9.19    Nonlinear system identification       ' 
'exam9_20 Example 9.20    Identification of a chemical process  ' 
];

fdsp_fig = ...
[
'fig1_4   Figure 1.4      Magnitude response of a notch filter                 '
'fig1_6   Figure 1.6      Error signal with active noise control               '
'fig1_7   Figure 1.7      A continuous-time signal x_a(t)                      '
'fig1_8   Figure 1.8      A discrete-time signal x(k)                          '
'fig1_9   Figure 1.9      Quantizer input-output characteristic                '
'fig1_10  Figure 1.10     A digital signal x_q(k)                              '
'fig1_11  Figure 1.11     Unit impulse and unit step                           '
'fig1_15  Figure 1.15     Impulse response of an ideal lowpass filter          '
'fig1_17  Figure 1.17     Sampled signal using impulse sampling                '
'fig1_18  Figure 1.18     Sampled spectrum with aliasing                       '
'fig1_19  Figure 1.19     Common samples of two bandlimited signals            '
'fig1_20  Figure 1.20     Sampled spectrum with no aliasing                    '
'fig1_23  Figure 1.23     Impulse response of a zero-order hold filter         '
'fig1_24  Figure 1.24     Signal reconstruction with a zero-order hold         '
'fig1_27  Figure 1.27     Butterworth filter magnitude responses               '
'fig1_30  Figure 1.30     Magnitude response of a zero-order hold              '
'fig1_31  Figure 1.31     Magnitude spectra of DAC input and output            '
'fig1_32  Figure 1.32     Magnitude spectra with oversampling                  '
'fig1_34  Figure 1.34     ADC input-output characteristic                      '
'                                                                              '
'fig2_3   Figure 2.3      Typical region of convergence (ROC)                  '
'fig2_4   Figure 2.4      Z-transform of unit step                             '
'fig2_5   Figure 2.5      Z-transform of causal exponentials                   '
'fig2_6   Figure 2.6      Z-transform of exponentially damped sine             '
'fig2_19  Figure 2.19     A bounded signal                                     '
'fig2_20  Figure 2.20     Region of stable poles                               '
'fig2_21  Figure 2.21     Stable parameter region of a second-order system     '
'                                                                              '
'fig3_3   Figure 3.3      Frequency response                                   '
'fig3_6   Figure 3.6      Magnitude and phase spectra                          '
'fig3_7   Figure 3.7      Periodic mod(k,N) funtion                            '
'fig3_11  Figure 3.11     Computational effort of FFT and DFT                  '
'fig3_29  Figure 3.29     Data windows                                         '
'fig3_37  Figure 3.37     Saturation due to clipping                           '
'figp3_14 Figure p3.14    Probability density function                         '
'figp3_22 Figure p3.22    Noise-corrupted signal                               '
'figp3_26 Figure p3.26    Periodic pulse train                                 '
'figp3_27 Figure p3.27    Dead-zone nonlinearity                               '
'                                                                              '
'fig4_2   Figure 4.2      Segment of recorded vowel O                          ' 
'fig4_4   Figure 4.4      Signal received at radar station                     ' 
'fig4_9   Figure 4.9      Computational effort for fast convolution            '
'fig4_16  Figure 4.16     Computational effort for fast cross-correlation      '
'fig4_19  Figure 4.19     Auto-correlation of white noise                      '
'                                                                              '
'fig5_1   Figure 5.1      Magnitude response of lowpass Chebyshev-I filter     '
'fig5_4   Figure 5.4      Magnitude Response of quantized Chebyshev-I filter   '
'fig5_5   Figure 5.5      Ideal frequency-selective magnitude responses        '
'fig5_6   Figure 5.6      Linear design specifications, lowpass filter         '
'fig5_7   Figure 5.7      Linear design specificatoins, highpass filter        '
'fig5_8   Figure 5.8      Linear design specifications, bandpass filter        '
'fig5_9   Figure 5.9      Linear design specififations, bandstop filter        '
'fig5_11  Figure 5.11     Logarithmic Design specifications, lowpass Filter    '
'fig5_13  Figure 5.13     Impulse responses of linear-phase FIR filters        '
'fig5_14  Figure 5.14     Poles and zeros of a type 1 linear-phase FIR filter  '
'fig5_15  Figure 5.15     Pole-zero plots of filters with the same A(f)        '
'fig5_37  Figure 5.37     Quantization operator input-output characteristic    '
'fig5_46  Figure 5.46     Realizable pole locations of quantized filter        '
'                                                                              '
'fig6_3   Figure 6.3      Second-order backwards differentiator                '
'fig6_5   Figure 6.5      Amplitude response specificaiton of an FIR filter    '
'fig6_8   Figure 6.8      Windows used to taper truncated impulse response     '
'fig6_18  Figure 6.18     Optimal equiripple amplitude response                '
'                                                                              '
'fig7_1   Figure 7.1      A narrowband filter bank                             '
'fig7_17  Figure 7.17     Magnitude response of a bank of subfilters           '
'fig7_29  Figure 7.29     Magnitude response of zero-order hold for DAC        '
'                                                                              '
'fig8_2   Figure 8.2      Magnitude response of a plucked-string filter        '
'fig8_4   Figure 8.4      Magnitude response of an ideal bandpass filter       '
'fig8_5   Figure 8.5      Power density spectrum of colored noise              '
'fig8_10  Figure 8.10     Poles and zeros of a comb filter                     '
'fig8_11  Figure 8.11     Magnitude response of a comb filter                  '
'fig8_12  Figure 8.12     Poles and zeros of an inverse comb filter            '
'fig8_13  Figure 8.13     Magnitude response of an inverse comb filter         '
'fig8_14  Figure 8.14     Design specifications of a lowpass filter            '
'fig8_15  Figure 8.15     Magnitude response of a Butterworth lowpass filter   '
'fig8_16  Figure 8.16     Poles of normalized lowpass Butterworth filters      '
'fig8_17  Figure 8.17     Magnitude response of a Chebyshev-I lowpass filter   '
'fig8_18  Figure 8.18     Magnitude response of a Chebyshev-II lowpass filter  '
'fig8_19  Figure 8.19     Magnitude response of an elliptic lowpass filter     '
'fig8_20  Figure 8.20     Trapezoid rule integration                           '
'fig8_21  Figure 8.21     Bilinear transformation from s plane to z plane      '
'fig8_22  Figure 8.22     Frequency warping caused by bilinear transformation  '
'                                                                              '
'fig9_38  Figure 9.38     Gaussian and raised-cosine radial basis functions    '
];

fdsp_prob = ...
[
'prob1_2  Problem 1.2  (Analysis)      '
'prob1_10 Problem 1.10 (Analysis)      '
'prob1_16 Problem 1.16 (Analysis)      '
'prob1_22 Problem 1.22 (GUI Simulation)'
'prob1_26 Problem 1.26 (GUI Simulation)'
'prob1_32 Problem 1.32 (Computation)   '
'prob2_14 Problem 2.14 (Analysis)      '
'prob2_22 Problem 2.22 (Analysis)      '
'prob2_32 Problem 2.32 (Analysis)      '
'prob2_35 Problem 2.35 (GUI Simulation)'
'prob2_38 Problem 2.38 (GUI Simulation)'
'prob2_43 Problem 2.43 (Computation)   '
'prob3_7  Problem 3.7  (Analysis)      '
'prob3_15 Problem 3.15 (Analysis)      '
'prob3_18 Problem 3.18 (GUI Simulation)'
'prob3_21 Problem 3.21 (GUI Simulation)'
'prob3_27 Problem 3.27 (Computation)   '
'prob4_5  Problem 4.5  (Analysis)      '
'prob4_10 Problem 4.10 (Analysis)      '
'prob4_19 Problem 4.19 (GUI Simulation)'
'prob4_22 Problem 4.22 (GUI Simulation)'
'prob4_30 Problem 4.30 (Computation)   '
'prob4_33 Problem 4.33 (Computation)   '
'prob5_2  Problem 5.2  (Analysis)      '
'prob5_14 Problem 5.14 (Analysis)      '
'prob5_23 Problem 5.23 (Analysis)      '
'prob5_36 Problem 5.36 (GUI Simulation)'
'prob5_39 Problem 5.39 (GUI Simulation)'
'prob5_44 Problem 5.44 (Computation)   '
'prob5_46 Problem 5.46 (Computation)   '
'prob6_4  Problem 6.4  (Analysis)      '
'prob6_10 Problem 6.10 (Analysis)      '
'prob6_18 Problem 6.18 (GUI Simulation)'
'prob6_23 Problem 6.23 (GUI Simulation)'
'prob6_26 Problem 6.26 (Computation)   '
'prob6_31 Problem 6.31 (Computation)   '
'prob7_3  Problem 7.3  (Analysis)      '
'prob7_10 Problem 7.10 (Analysis)      '
'prob7_20 Problem 7.20 (GUI Simulation)'
'prob7_25 Problem 7.25 (GUI Simulation)'
'prob7_27 Problem 7.27 (Computation)   '
'prob7_30 Problem 7_30 (Computation)   '
'prob8_10 Problem 8.10 (Analysis)      '
'prob8_16 Problem 8.16 (Analysis)      '
'prob8_26 Problem 8.26 (GUI Simulation)'
'prob8_33 Problem 8.33 (GUI Simulation)'
'prob8_40 Problem 8.40 (Computation)   '
'prob8_43 Problem 8.43 (Computation)   '
'prob9_8  Problem 9.8  (Analysis)      '
'prob9_16 Problem 9.16 (Analysis)      '
'prob9_25 Problem 9.25 (GUI Simulation)'
'prob9_30 Problem 9.30 (GUI Simulation)'
'prob9_34 Problem 9.34 (Computation)   '
'prob9_39 Problem 9.39 (Computation)   '
]; 

fdsp_help = ...
[
'0  Main Program Support                     '
'1  Sampling and Reconstruction              '   
'2  Discrete-Time Systems                    '
'3  The FFT and Spectral Analysis            '
'4  Correlation and Convolution              '
'5  Filter Specifications and Structures     '
'6  FIR Filter Design                        '
'7  Multirate Signal Processing              '
'8  IIR Filter Design                        '
'9  Adaptive Signal Processing               '
];

fdsp_fun = ...
[
'0  f_dsp         : FDSP Driver module                                  '
'0  f_caliper     : Measure points on plot using mouse cross hairs      '
'0  f_clip        : Clip output to an interval                          '
'0  f_deadzone    : Zero output within an interval                      '
'0  f_getsound    : Record sound from microphone                        '
'0  f_labels      : Add title and axis labels to graph                  '
'0  f_prompt      : Prompt for number in specified range                '
'0  f_randinit    : Initialize random number generator                  '
'0  f_randu       : Uniformly distributed random matrix                 '
'0  f_randg       : Gaussian random matrix                              '
'0  f_tocol       : Convert vector to column                            '
'0  f_torow       : Convert vector to row                               '
'0  f_version     : MATLAB and FDSP version numbers                     '
'0  f_wait        : Display message and wait for key                    '
'                                                                       '
'1  g_sample      : GUI module: Signal sampling                         '
'1  g_reconstruct : GUI module: Signal reconstruction                   '
'1  f_adc         : Analog-to-digital converter                         '
'1  f_dac         : Digital-to-analog converter                         '
'1  f_quant       : Quantize operator                                   '
'1  f_freqs       : Continuous-time frequency response                  '
'                                                                       '
'2  g_system      : GUI module: Discrete-time systems                   ' 
'2  f_freq        : Discrete-time frequency response                    '
'2  f_impulse     : Compute impulse response                            '
'2  f_pzplot      : Pole-zero sketch                                    '
'2  f_pzsurf      : Plot transfer function magnitude as a surface       '
'2  f_spec        : Find signal spectra                                 '
'                                                                       '
'3  g_spectra     : GUI module: Signal spectra                          ' 
'3  f_freqz       : Discrete-time frequency response using DFT          '
'3  f_pds         : Estimate power density spectrum                     '
'3  f_specgram    : Spectrogram of a signal                             '
'3  f_unscramble  : Convert FFT output to frequency range -fs/2 to fs/2 '
'3  f_window      : Data windows                                        '
'                                                                       '
'4  g_correlate   : GUI module: Convolution and correlation             ' 
'4  f_conv        : Fast linear and circular convolution                '
'4  f_corr        : Fast linear and circular correlation                '
'4  f_blockconv   : Fast linear block convolution                       '
'                                                                       '
'5  g_filters     : GUI module: Filter specifications and structures    ' 
'5  f_cascade     : Find cascade form realization of IIR filter         '
'5  f_filtcas     : Evaluate cascade form IIR filter output             '
'5  f_filtlat     : Evaluate lattice form FIR filter output             '
'5  f_filtpar     : Evaluate parallel form IIR filter output            '
'5  f_lattice     : Find lattice form realization of FIR filter         '
'5  f_minall      : Minimum-phase decompositon of IIR filter            '
'5  f_parallel    : Find parallel form realization of IIR filter        '
'                                                                       '
'6  g_fir         : GUI module: FIR filter design                       ' 
'6  f_firamp      : Amplitude response function for an FIR filter       '
'6  f_firls       : Design least squares digital FIR filter             '
'6  f_firsamp     : Design frequency sampled digital FIR filter         '
'6  f_firwin      : Design windowed digital FIR filter                  '
'6  f_firparks    : Design Parks-McLellen equiripple FIR filter         '
'                                                                       '
'7  g_multirate   : GUI module: Multirate signal processing             '
'7  f_decimate    : Integer sampling rate decimator                     '
'7  f_interpol    : Integer sampling rate interpolator                  '
'7  f_rateconv    : Rational sampling rate converter                    '
'                                                                       '
'8  g_iir         : GUI module: IIR filter design                       ' 
'8  f_bilin       : Bilinear transformation IIR design method           '
'8  f_butters     : Design Butterworth analog lowpass filter            '
'8  f_butterz     : Design Butterworth digital filter                   '
'8  f_chebpoly    : Evaluate Chebyshev polynomial of first kind         '
'8  f_cheby1s     : Design Chebyshev-I analog lowpass filter            '
'8  f_cheby1z     : Design Chebyshev-I digital filter                   '
'8  f_cheby2s     : Design Chebyshev-II analog lowpass filter           '
'8  f_cheby2z     : Design Chebyshev-II digital filter                  '
'8  f_elliptics   : Design elliptic analog lowpass filter               '
'8  f_ellipticz   : Design elliptic digital filter                      '
'8  f_iircomb     : Design IIR comb filter                              '
'8  f_iirinv      : Design IIR inverse comb filter                      '
'8  f_iirnotch    : Design IIR notch filter                             '
'8  f_iirres      : Design IIR resonator filter                         '
'8  f_low2bps     : Analog lowpass to bandpass transformation           '
'8  f_low2bss     : Analog lowpass to bandstop transformation           '
'8  f_low2highs   : Analog lowpass to highpass transformation           '
'8  f_low2lows    : Analog lowpass to lowpass transformation            '
'8  f_reverb      : Reverb filter                                       '
'8  f_string      : Plucked-string filter                               '
'                                                                       '
'9  g_adapt       : GUI module: Adaptive signal processing              ' 
'9  f_lms         : Least mean square (LMS) method                      ' 
'9  f_normlms     : Normalized LMS method                               ' 
'9  f_corrlms     : Correlation LMS method                              ' 
'9  f_leaklms     : Leaky LMS method                                    ' 
'9  f_rls         : Recursive least square (RLS) method                 ' 
'9  f_fxlms       : Filter-x LMS method                                 ' 
'9  f_sigsyn      : Signal-synthesis method                             ' 
'9  f_rbfw        : Raised-cosine RBF learning algorithm                ' 
'9  f_rbf0        : Raised-cosine RBF network output                    ' 
'9  f_state       : State vector of discrete-time system                ' 
'9  f_rbfg        : Raised-cosine RBF function                          ' 
'9  f_neighbors   : Indices of RBF grid point neighbors                 ' 
'9  f_gridpoint   : State vector for RBF grid point                     ' 
];

% Create figure

light_gray = [0.9 0.9 0.9];
margin = 0.06;
fdsp_title = 'Driver Module => f_dsp';
hf_1 = figure('NumberTitle','off',...
              'Name',fdsp_title,...
              'Color',light_gray,...
              'Units','normalized',...
              'Position',[margin,margin,1-2*margin,1-2*margin]);
%if matlab_version <= 6.1
%    set (hf_1,'Renderer','zbuffer')
%end
if matlab_version >= 7.0
    set (hf_1,'DockControl','off')
end
if instructor
   f_logo ('FDSP Toolbox',1)
else
   f_logo ('FDSP Toolbox')
end

% Top Level Menu

set (hf_1,'MenuBar',menubar)
if instructor 
    hm_7 = uimenu (hf_1,'Label','Homework Builder');
end
hm_0 = uimenu (hf_1,'Label','GUI modules');
hm_1 = uimenu (hf_1,'Label','Examples','Separator','off');
hm_2 = uimenu (hf_1,'Label','Figures','Separator','off');
hm_3 = uimenu (hf_1,'Label','Problems','Separator','off');
hm_4 = uimenu (hf_1,'Label','Help');
hm_6 = uimenu (hf_1,'Label','Web','Separator','off');
hm_5 = uimenu (hf_1,'Label','Exit','Callback','close, clc, return');

%---------------------------------------------------------------
% Run homework builder (requires Instructor's CD)
%---------------------------------------------------------------

if instructor
    cback = sprintf('%s; h_fig=gcf; set(h_fig,''Selected'',''on''); ','g_homework');
    run_01(num_guis+1) = uimenu(hm_7,'Label','g_homework','Callback',cback);
end

%----------------------------------------------------------------
% Run GUI modules
%----------------------------------------------------------------

for i = 1 : num_guis
   gmod = guis(i,:); 
   cback = sprintf('%s; h_fig=gcf; set(h_fig,''Selected'',''on''); ',gmod);
   run_01(i) = uimenu(hm_0,'Label',fdsp_guis(i,16:end),'Callback',cback); 
end
%if instructor
%    cback = sprintf('%s; h_fig=gcf; set(h_fig,''Selected'',''on''); ','g_homework');
%    run_01(num_guis+1) = uimenu(hm_0,'Label','g_homework',...
%           'Separator','on','Callback',cback);
%end
 
%----------------------------------------------------------------
% Run examples 
%----------------------------------------------------------------

for i = 1 : num_chap
   run_1(i) = uimenu (hm_1,'Label',sprintf('Chapter %g',i));
end

[m,n] = size (fdsp_exam);
num_exam = zeros(11,1);               % number of examples 
for i = 1 : m

   cback = sprintf (...
    ['set(gcf,''Visible'',''off''), save f_dsp, %s, clear, load f_dsp, delete(''f_dsp.mat''), '...
     'clc, set(gcf,''Visible'',''on'')'], fdsp_exam(i,1:8));
    label = deblank(fdsp_exam(i,10:n));

% Chapters 

   for j = 1 : num_chap
      s = sprintf('exam%g',j);
      if (strcmp(fdsp_exam(i,1:5),s)) & (fdsp_exam(i,6) ~= '0')
         num_exam(j) = num_exam(j) + 1;
         run_11(num_exam(j)) = uimenu (run_1(j),'Label',label,...
                              'Callback',cback);
      end
   end
   
end

%----------------------------------------------------------------
% Run figures 
%----------------------------------------------------------------

for i = 1 : num_chap
   run2(i) = uimenu (hm_2,'Label',sprintf('Chapter %g',i));
end

[m,n] = size (fdsp_fig);
num_fig = zeros(11,1);               % number of figures 
for i = 1 : m
   cback = sprintf (...
     ['set(gcf,''Visible'',''off''), save f_dsp, %s, clear, load f_dsp, delete (''f_dsp.mat''), '...
      'clc, set(gcf,''Visible'',''on'')'], fdsp_fig(i,1:8));
   label = deblank(fdsp_fig(i,10:n));

% Chapters 

   for j = 1 : num_chap
      s = sprintf('fig%g',j);
      if (strcmp(fdsp_fig(i,1:4),s)) & (fdsp_fig(i,5) ~= '0')
         num_fig(j) = num_fig(j) + 1;
         run21(num_fig(j)) = uimenu (run2(j),'Label',label,...
                              'Callback',cback);
      end
   end
end

%----------------------------------------------------------------
% Run Problems 
%----------------------------------------------------------------

olddir = pwd;
fdspdir = [matlabroot filesep 'toolbox' filesep 'fdsp' filesep 'fdsp'];
cd (fdspdir)
   
try getpref('FDSP_preferences','reader_file');   
   
   reader_path = getpref ('FDSP_preferences','reader_path');
   reader_file = getpref ('FDSP_preferences','reader_file');
   for i = 1 : num_chap
      run3(i) = uimenu (hm_3,'Label',sprintf('Chapter %g',i));
   end

   [m,n] = size (fdsp_prob);
   num_prob = zeros(10,1);               % number of problems

   for i = 1 : m
 
      label = deblank(fdsp_prob(i,10:n));
      pdf_file = which([deblank(fdsp_prob(i,1:8)) '.pdf']);
      cback = [...
       'fprintf (''Initializing Adobe Acrobat Reader...\n''); '...       
       'work_dir = pwd; '...
       sprintf('cd(''%s''), ',reader_path)...
       'set(gcf,''Visible'',''off''), '...
       sprintf('system (''%s %s''), ',reader_file,pdf_file)...
       'clc, set(gcf,''Visible'',''on''), '...
       'cd(work_dir);'
     ];
   
% Chapters 

      for j = 1 : num_chap
         s = sprintf('prob%g',j);
         if (strcmp(fdsp_prob(i,1:5),s)) & (fdsp_prob(i,6) ~= '0')
            num_prob(j) = num_prob(j) + 1;
            run31(num_prob(j)) = uimenu (run3(j),'Label',label,...
                                 'Callback',cback);
         end
      end
   end

catch

    cback = ['helpwin (''f_regreader'')'];
    hm_30 = uimenu (hm_3,'Label','Help','Callback',cback);
    
end

%if instructor
    
 %  olddir = pwd;
 %  fdspdir = [matlabroot filesep 'toolbox' filesep 'fdsp' filesep 'fdsp'];
 %  cd (fdspdir)
 
 %   try 

 %       reader_path = getpref ('FDSP_preferences','reader_path');
 %       reader_file = getpref ('FDSP_preferences','reader_file');
   
 %       hm32 = uimenu (hm_3,'Label','Select entire chapter','Separator','on');
 %       cback_solvechap = [
 %                          'problist = problems(prob,2); '...
 %                          '[s,v] = listdlg(''PromptString'','...
 %                          '''Select chapter number.'','...
 %                          '''ListSize'',[150 300],'...
 %                          '''SelectionMode'',''single'','...
 %                          '''ListString'',nums(1:9)); '...
 %                          'pdf_file = sprintf(''problems_%d.pdf'',s); '...
 %                          'pdf_file = which(pdf_file); '...
 %                          'fprintf (''Initializing Adobe Acrobat Reader...\n''); '...       
 %                          'work_dir = pwd; '...
 %                          sprintf('cd(''%s''); ',reader_path)...
 %                          'set(gcf,''Visible'',''off''); '...
 %                          'eval( [''system('' quote reader_file space pdf_file quote '')''] ); '...
 %                          'set(gcf,''Visible'',''on''); '...
 %                          'clc, cd(work_dir);' 
 %                          ];
%        set (hm32,'Callback',cback_solvechap)         

%   catch 

%        cback = ['helpwin (''f_regreader'')'];
%        hm_30 = uimenu (hm_3,'Label','Help','Callback',cback);
   
%    end
    
%end

% Reader updates   
   
cback = ['if f_regreader, '...
         '  close, f_dsp, '...
         'end'];
hm_33 = uimenu (hm_3,'Separator','on','Label','Register Acrobat Reader with FDSP','Callback',cback);
cback = ['web http://www.adobe.com/products/acrobat/readstep2.html;'];
hm_34 = uimenu (hm_3,'Label','Download Adobe Acrobat Reader','Callback',cback);
cd (olddir)    
    
%----------------------------------------------------------------
% Help Menu
%----------------------------------------------------------------

% User tips             
          
cback = ['set(gcf,''Selected'',''off''); helpwin f_tipsfdsp; set(gcf,''Selected'',''on'')'];
hm_43 = uimenu (hm_4,'Label','User Tips','Separator','off','Callback',cback);

% Function Help

hm_42 = uimenu (hm_4,'Label','Toolbox functions');
[m,n] = size(fdsp_help);
num_fun = zeros(m,1);               % number of functions

for i = 1 : m
   nhelp(i) = uimenu (hm_42,'Label',sprintf('%s',fdsp_help(i,1:n)));
end

[p,q] = size(fdsp_fun);
for i = 1 : p

   cback = sprintf (...
     'set(gcf,''Selected'',''off''); helpwin %s; set(gcf,''Selected'',''on'')',...
      fdsp_fun(i,4:16));

   label = [fdsp_fun(i,4:16) fdsp_fun(i,19:q)];
   
% Chapters 

   for j = 1 : num_chap+1
      s = sprintf('%g',j-1);
      if strcmp(fdsp_fun(i,1),s) & ~strcmp(fdsp_fun(i,2),'0')
         num_fun(j) = num_fun(j) + 1;
         nhelp11(num_fun(j)) = uimenu (nhelp(j),'Label',label,...
                              'Callback',cback);
         if fdsp_fun(i,15) == '.'
           set (nhelp11(num_fun(j)),'Separator','on')
         end
      end
   end

end

% GUI Modules Help

hm_41 = uimenu (hm_4,'Label','Toolbox GUI modules');

for i = 1 : num_guis
   gmod = guis(i,:);
   cback = sprintf (...
     'set(gcf,''Selected'',''off''); helpwin %s; set(gcf,''Selected'',''on'')',...
      gmod);
   nhelp(i) = uimenu (hm_41,'Label',gmod,'Callback',cback);
end
if instructor
   cback = sprintf (...
      'set(gcf,''Selected'',''off''); helpwin %s; set(gcf,''Selected'',''on'')',...
      'g_homework');
   nhelp(num_guis+1) = uimenu (hm_41,'Label','g_homework','Separator','on','Callback',cback);
end

% Examples help

hm_46 = uimenu (hm_4,'Label','Toolbox examples');
for i = 1 : num_chap
   help_1(i) = uimenu (hm_46,'Label',sprintf('Chapter %g',i));
end

[m,n] = size (fdsp_exam);
num_exam = zeros(11,1);               % number of examples 
for i = 1 : m

   cback = sprintf (...
    ['set(gcf,''Selected'',''off''), helpwin %s, '...
     'set(gcf,''Selected'',''on'')'], fdsp_exam(i,1:8));
    label = deblank(fdsp_exam(i,10:n));

% Chapters 

   for j = 1 : num_chap
      s = sprintf('exam%g',j);
      if (strcmp(fdsp_exam(i,1:5),s)) & (fdsp_exam(i,6) ~= '0')
         num_exam(j) = num_exam(j) + 1;
         help_11(num_exam(j)) = uimenu (help_1(j),'Label',label,...
                              'Callback',cback);
      end
   end
   
end

% Figures Help

hm_45 = uimenu (hm_4,'Label','Toolbox figures');
for i = 1 : num_chap
   run2(i) = uimenu (hm_45,'Label',sprintf('Chapter %g',i));
end

[m,n] = size (fdsp_fig);
num_fig = zeros(11,1);               % number of figures 
for i = 1 : m
   cback = sprintf (...
     ['set(gcf,''Selected'',''off''), helpwin %s, '...
      'set(gcf,''Selected'',''on'')'], fdsp_fig(i,1:8));
   label = deblank(fdsp_fig(i,10:n));

% Chapters 

   for j = 1 : num_chap
      s = sprintf('fig%g',j);
      if (strcmp(fdsp_fig(i,1:4),s)) & (fdsp_fig(i,5) ~= '0')
         num_fig(j) = num_fig(j) + 1;
         run21(num_fig(j)) = uimenu (run2(j),'Label',label,...
                              'Callback',cback);
      end
   end
end

% General information             
          
cback = ['set(gcf,''Selected'',''off''); helpwin f_infofdsp; set(gcf,''Selected'',''on'')'];
hm_44 = uimenu (hm_4,'Label','General Information','Separator','on','Callback',cback);

% About fdsp             
          
cback = ['set(gcf,''Selected'',''off''); helpwin f_dsp; set(gcf,''Selected'',''on'')'];
hm_45 = uimenu (hm_4,'Label','About f_dsp','Separator','off','Callback',cback);

% Web 

cback = 'helpwin f_updates';
hm_61 = uimenu (hm_6,'Label','FDSP Updates','Callback',cback);

cback = ['web http://www.brookscole.com/'];
hm_65 = uimenu (hm_6,'Label','Brooks/Cole Publishing','Callback',cback);

cback = ['web http://www.matlab.com/'];
hm_66 = uimenu (hm_6,'Label','The MathWorks','Callback',cback);

hm_64 = uimenu (hm_6,'Label','Authors','Separator','off');
cback = ['web http://www.clarkson.edu/~schillin/;'];
hm_641 = uimenu (hm_64,'Label','R. J. Schilling','Callback',cback);
cback = ['web http://www.clarkson.edu/chemeng/faculty/harris.html;'];
hm_642 = uimenu (hm_64,'Label','S. L. Harris','Callback',cback);
