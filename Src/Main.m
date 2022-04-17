% Alunos:
%   Bruna Casagranda Cagliari (290515)
%   Gabriel Lando (291399)

clear;
close;
clc;

% carrega o package Communications pra usar as fun��es de encode e decode
pkg load communications;

% Constantes configuraveis 
Constants;

% Constantes derivadas
Eb_N0_lin = 10 .^ (Eb_N0_dB/10); % faixa de Eb/N0 linearizada
ber_psk = zeros(size(Eb_N0_lin)); % pr�-aloca��o do vetor de BER para o PSK
ber_qam = zeros(size(Eb_N0_lin)); % pr�-aloca��o do vetor de BER para o QAM
NP_PSK = Eb_PSK ./ (Eb_N0_lin); % vetor de pot�ncias do ru�do para o PSK
NP_QAM = Eb_QAM ./ (Eb_N0_lin); % vetor de pot�ncias do ru�do para o QAM
NA_PSK = sqrt(NP_PSK); % vetor de amplitudes do ru�do para o PSK
NA_QAM = sqrt(NP_QAM); % vetor de amplitudes do ru�do para o QAM

disp("Gerando vetor de bits...");
info = Info(num_b);
bits = info.generateData();

disp("Codificando vetor de bits...");
codec = Codec(p);
enc_data = codec.encode(bits);

psk = PSK(Mod);
qam = QAM(Mod);

disp("Modulando vetor de bits usando PSK...");
psk_mod_data = psk.modulate(enc_data);
disp("Modulando vetor de bits usando QAM...");
qam_mod_data = qam.modulate(enc_data);

for i = 1:length(Eb_N0_lin)
  fprintf("[%d] Gerando ruido no vetor de bits do PSK...\n", i);
  psk_noise = NoiseGen.generate(psk_mod_data, NA_PSK(i));
  fprintf("[%d] Gerando ruido no vetor de bits do QAM...\n", i);
  qam_noise = NoiseGen.generate(qam_mod_data, NA_QAM(i));
  
  fprintf("[%d] Demodulando vetor de bits PSK...\n", i);
  psk_demod_data = psk.demodulate(psk_noise);
  fprintf("[%d] Demodulando vetor de bits QAM...\n", i);
  qam_demod_data = qam.demodulate(qam_noise);

  fprintf("[%d] Decodificando vetor de bits PSK...\n", i);
  psk_dec_data = codec.decode(psk_demod_data);
  fprintf("[%d] Decodificando vetor de bits QAM...\n", i);
  qam_dec_data = codec.decode(qam_demod_data);
  
  fprintf("[%d] Calculando BER para PSK...\n", i);
  ber_psk(i) = info.getBER(psk_dec_data);
  fprintf("[%d] Calculando BER para QAM...\n", i);
  ber_qam(i) = info.getBER(qam_dec_data);
end


% Plota o BER
disp("Gerando gr�ficos...");
figure
hold on
semilogy(Eb_N0_dB, ber_psk, '-','LineWidth',2,'Color','blue');
semilogy(Eb_N0_dB, ber_qam,'-','LineWidth',2,'Color','red');
