pkt_size = 4; % Tamanho da mensagem
num_bits = 11 * 10 * 1000; % Número de bits a serem simulados
modulacao = 16; % Ordem de modulação para M-PSK/M-QAM
Eb_N0_dB = -2:1:12; %faixa de Eb/N0
Eb_PSK = 1/4; % energia por bit para a modulação PSK utilizada
Eb_QAM = 10/4; % energia por bit para a modulação QAM utilizada
