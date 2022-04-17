clear;
close;
num_b = 1000000; %n�mero de bits a serem simulados
bits = complex(2*randi(2, 1, num_b)-3, 0); %bits aleat�rios modulados em BPSK (parte real em 1 e -1)
Eb_N0_dB = 0:1:9; %faixa de Eb/N0
Eb_N0_lin = 10 .^ (Eb_N0_dB/10); %faixa de Eb/N0 linearizada
ber = zeros(size(Eb_N0_lin)); %pr�-aloca��o do vetor de BER
Eb = 1; % energia por bit para a modula��o BPSK utilizada

NP = Eb ./ (Eb_N0_lin); %vetor de pot�ncias do ru�do
NA = sqrt(NP); %vetor de amplitudes do ru�do
    
for i = 1:length(Eb_N0_lin)
    n = NA(i)*complex(randn(1, num_b), randn(1, num_b))*sqrt(0.5); %vetor de ru�do complexo com desvio padr�o igual a uma posi��o do vetor NA
    r = bits + n; % vetor recebido
    demod = sign(real(r)); % recupera a informa��o (sinal da parte real)
    ber(i) = sum(bits ~= demod) / num_b; % contagem de erros e c�lculo do BER
end

semilogy(Eb_N0_dB, ber);