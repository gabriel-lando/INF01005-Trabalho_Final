%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Classe: NoiseGen %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Essa classe contempla o gerador de ruidos sobre o sinal modulado

classdef NoiseGen
  methods (Static)
    function ret = generate(data, na)
      noise = na*complex(randn(1, length(data)), randn(1, length(data)))*sqrt(0.5); %vetor de ru�do complexo com desvio padr�o igual a uma posi��o do vetor NA
      ret = data + noise; % vetor recebido
    end
  end
end
