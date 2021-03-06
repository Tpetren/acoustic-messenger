function [pack, psd, const, eyed] = receiver(tout,fc)
%receiver PC_A receiver script
%   tout - Time out for receiver. Will return after this time if no message
%   is detected.
%   fc - Carrier frequency to listen on.

recTime = 1; % Seconds to record waveform
fsfd = 4*fc; % Samples per symbol

pack = []; psd = [];  const=[]; eyed = [];

% Wait for a message for tout amount of time.
foundMessage = detectMessage(tout, fc);

% Exit if we didn't find anything.
if foundMessage == 0
   return;
end

% Record the raw waveform
noisyWaveform = recordWaveform(recTime);

% Frequency/phase detection and shift to baseband
iWaveform, qWaveform = shift2baseband(noisyWaveform, fc);

% Pass the baseband signal through a low-pass filter
iWaveformFiltered, qWaveformFiltered = lowpass(iWaveform, qWaveform);

% Run waveform through the matched filter
iMatched, qMatched = matchedFilter(iWaveformFiltered, qWaveformFiltered);

% Detect sampling time and sample
symbolSequence = sampleMatched(iMatched, qMatched);

% Frame synchronization and convert symbol sequence to bits
bitSequence = symbols2bits(symbolSequence);

pack = bitSequence;


end