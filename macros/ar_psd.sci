function [P, F]= ar_psd(A, varargin)
//Calculate the power spectrum of the autoregressive model
//Calling Sequence
// [PSD,F_OUT]=ar_psd (A, V)
// [PSD,F_OUT]=ar_psd (A, V, FREQ)
// [PSD,F_OUT]=ar_psd (A, V, FREQ, FS)
// [PSD,F_OUT]=ar_psd (..., RANGE)
// [PSD,F_OUT]=ar_psd (..., METHOD)
// [PSD,F_OUT]=ar_psd (..., PLOTTYPE)
//Parameters 
//A:List of M=(order+1) autoregressive model coefficients. The first element of "ar_coeffs" is the zero-lag coefficient, which always has a value of 1.
//V:Square of the moving-average coefficient of the AR model.
//FREQ:Frequencies at which power spectral density is calculated, or a scalar indicating the number of uniformly distributed frequency values at which spectral density is calculated.  (default = 256)
//FS:Sampling frequency (Hertz) (default=1)
//Range: 'half', 'onesided' : frequency range of the spectrum is from zero up to but not including sample_f/2. Power from negative frequencies is added to the positive side of the spectrum.'whole', 'twosided' : frequency range of the spectrum is-sample_f/2 to sample_f/2, with negative frequencies stored in "wrap around" order after the positive frequencies; e.g. frequencies for a 10-point 'twosided' spectrum are 0 0.1 0.2 0.3 0.4 0.5 -0.4 -0.3 -0.2 -0.1 'shift', 'centerdc' : same as 'whole' but with the first half of the spectrum swapped with second half to put the zero-frequency value in the middle.  (See "help fftshift". If "freq" is vector, 'shift' is ignored.  If model coefficients "ar_coeffs" are real, the default range is 'half', otherwise default range is 'whole'.
// Method:'fft': use FFT to calculate power spectrum.  'poly': calculate power spectrum as a polynomial of 1/z N.B. this argument is ignored if the "freq" argument is a vector.  The default is 'poly' unless the "freq" argument is an integer power of 2.
// Plot type:'plot', 'semilogx', 'semilogy', 'loglog', 'squared' or 'db':specifies the type of plot.  The default is 'plot', which means linear-linear axes.  'squared' is the same as 'plot'.  'dB' plots "10*log10(psd)".  This argument is ignored and a spectrum is not plotted if the caller requires a returned value.
//PSD: estimate of power-spectral density
//F_OUT: frequency values
//Description
//If the FREQ argument is a vector (of frequencies) the spectrum is calculated using the polynomial method and the METHOD argument is ignored.  For scalar FREQ, an integer power of 2, or METHOD = "FFT", causes the spectrum to be calculated by FFT. Otherwise, the spectrum is calculated as a polynomial.  It may be computationally more efficient to use the FFT method if length of the model is not much smaller than the number of frequency values.  The spectrum is scaled so that spectral energy (area under spectrum) is the same as the time-domain energy (mean square of the signal).	
//Examples
//[a,b]= ar_psd([1,2,3],2)
	
	funcprot(0);
	rhs= argn(2);
	if(rhs <2 | rhs>5)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 2 then
		[P,F]= callOctave("ar_psd", A, varargin(1));
	case 3 then
		[P,F]= callOctave("ar_psd", A, varargin(1), varargin(2));
	case 4 then
		[P,F]= callOctave("ar_psd", A, varargin(1), varargin(2), varargin(3));
	case 5 then
		[P,F]= callOctave("ar_psd", A, varargin(1), varargin(2), varargin(3), varargin(4));
	end
endfunction
