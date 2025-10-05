% 采样率
fs = 44100;

% 定义音阶频率 (C大调)，添加休止符处理
scale.C4 = 261.63; scale.D4 = 293.66; scale.E4 = 329.63;
scale.F4 = 349.23; scale.G4 = 392.00; scale.A4 = 440.00;
scale.B4 = 493.88; 
scale.C5 = 261.63*2; scale.D5 = 293.66*2; scale.E5 = 329.63*2; 
scale.F5 = 349.23*2; scale.G5 = 392.00*2; scale.A5 = 440.00*2; 
scale.B5 = 493.88*2; 
scale.C6 = 261.63*4; scale.D6 = 293.66*4; scale.E6 = 329.63*4; 
scale.F6 = 349.23*4; scale.G6 = 392.00*4; scale.A6 = 440.00*4; 
scale.B6 = 493.88*4;
scale.C7 = 261.63*8;

% 添加低音部分用于伴奏
scale.A3 = 220.00; scale.B3 = 246.94;
scale.C3 = 130.81; scale.D3 = 146.83; scale.E3 = 164.81;
scale.F3 = 174.61; scale.G3 = 196.00;

% 《无关风月》主旋律简谱
melody = {'E5', 'G5', 'A5', 'G5', 'A5', 'A5', 'C6', 'A5', ...
          'G5', 'G5', 'E5', 'G5', 'E5', 'D5', 'D5', 'C5', ...
          'C5', 'A4', 'C5', 'D5', 'E5', 'G5', 'E5',  ...  % 1
          'E5', 'G5', 'A5', 'G5', 'A5', 'A5', 'C6', 'A5', ...
          'G5', 'G5', 'A5', 'E5', 'E5', 'D5', 'D5', 'C5', ... 
          'C5', 'A4', 'C5', 'E5', 'A5', 'G5', ...    % 2
          'E5', 'G5', 'A5', 'G5', 'A5', 'A5', 'C6', 'A5', ...
          'G5', 'G5', 'E5', 'G5', 'E5', 'D5', 'D5', 'C5', ...
          'C5', 'A4', 'C5', 'D5', 'E5', 'G5', 'E5',...   % 3
          'E5', 'G5', 'A5', 'G5', 'A5', 'A5', 'C6', 'A5', ...
          'G5', 'G5', 'E5', 'G5', 'E5', 'D5', 'D5', 'C5', ...
          'D5', 'C5', 'A4', 'G4', 'A4', 'A4'};  

% 音符时长 (秒)
durations = [0.5, 0.5, 1.5, 0.5, 1.0, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 0.5, 1.0, 0.5, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 0.5, 0.5, 0.5, 1.0, 2.5, ...     % 1
             0.5, 0.5, 1.5, 0.5, 1.0, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 0.5, 1.0, 0.5, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 1.0, 0.5, 1.0, 2.5, ...     % 2
             0.5, 0.5, 1.5, 0.5, 1.0, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 0.5, 1.0, 0.5, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 0.5, 0.5, 0.5, 1.0, 2.5, ...    % 3
             0.5, 0.5, 1.5, 0.5, 1.0, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 0.5, 1.0, 0.5, 0.5, 0.5, 0.5, ...
             0.5, 0.5, 1.0, 0.5, 1.0, 3.0];

% 生成主旋律信号
music_signal = [];
for i = 1:length(melody)
    freq = scale.(melody{i});
    duration = durations(i);
    t = 0:1/fs:duration-1/fs;
    
    % 生成基本音符
    note = sin(2*pi*freq*t);
    
    % 简化包络 - 使用窗函数
    envelope = tukeywin(length(note), 0.3)';
    
    note = note .* envelope;
    music_signal = [music_signal, note];
end

% 伴奏部分
melody2 = {'rest','rest','A3','E4','A4','E4','A4','E4','A4','E4',...
           'G3','D4','G4','D4','G4','D4','G4','D4','F3','C4','F4',...
           'C4','G3','D4','G4','D4','C4','G4','C5','G4','C4','G4','C5','G4',...
           'A3','E4','A4','E4','A4','E4','A4','E4',...
           'G3','D4','G4','D4','G4','D4','G4','D4','F3','C4','F4',...
           'C4','G3','D4','G4','D4','C4','G4','C5','G4','C4','G4','C5','G4',...
           'A3','E4','A4','E4','A4','E4','A4','E4',...
           'G3','D4','G4','D4','G4','D4','G4','D4','F3','C4','F4',...
           'C4','G3','D4','G4','D4','C4','G4','C5','G4','C4','G4','C5','G4',...
           'A3','E4','A4','E4','A4','E4','A4','E4',...
           'G3','D4','G4','D4','G4','D4','G4','D4','F3','C4','F4',...
           'C4','G3','D4','G4','D4','A3','E4','A4','E4','A4'};

% 生成伴奏信号
music_signal2 = [];
for i = 1:length(melody2)
    duration = 0.5; % 伴奏每个音符固定0.5秒
    t = 0:1/fs:duration-1/fs;
    
    if strcmp(melody2{i}, 'rest')
        % 休止符：生成静音
        note2 = zeros(1, length(t));
    else
        % 正常音符
        freq2 = scale.(melody2{i});
        note2 = sin(2*pi*freq2*t);
        envelope2 = tukeywin(length(note2), 0.3)';
        note2 = note2 .* envelope2;
    end
    music_signal2 = [music_signal2, note2];
end

% 确保两个信号长度匹配（取较短的长度）
min_length = min(length(music_signal), length(music_signal2));
music_signal = music_signal(1:min_length);
music_signal2 = music_signal2(1:min_length);

% 混合主旋律和伴奏
final_music = music_signal * 0.7 + music_signal2 * 0.4;

% 归一化
final_music = final_music / max(abs(final_music));

% 播放混合后的音乐
sound(final_music, fs);

