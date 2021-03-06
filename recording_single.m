function recording_single(filename, outfile)
    audioFrameLength = 1024;
    fWave = dsp.AudioFileReader(filename,'SamplesPerFrame',audioFrameLength);
    fPlayer  = dsp.AudioPlayer('DeviceName','3-4 (OCTA-CAPTURE)','SampleRate', fWave.SampleRate);
    audioRec = dsp.AudioRecorder(...
        'DeviceName', ...
        '1-2 (OCTA-CAPTURE)',...
        'SampleRate', fWave.SampleRate, ...
        'NumChannels', 2,...
        'OutputDataType','double',...
        'QueueDuration', 2,...
        'SamplesPerFrame', audioFrameLength);
    fWriter = dsp.AudioFileWriter(outfile,...
        'FileFormat','wav',...
        'SampleRate', fWave.SampleRate);
    while (~isDone(fWave))
        step(fPlayer, step(fWave));
        step(fWriter, step(audioRec));
    end
    release(fWave);
    release(fPlayer);
    release(audioRec);
    release(fWriter);
    disp('Recording complete');
end
