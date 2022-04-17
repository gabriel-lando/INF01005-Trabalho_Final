%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Classe: Codec %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Essa classe contempla o codificador e decodificador dos dados utilizando o algoritmo Hamming

classdef Codec < handle
  properties
    n; % Valor do tamanho total da mensagem com bits de informação e paridade
    k; % Tamanho da mensagem
  end
  methods
    function obj = Codec(p)
      obj.n = 2^p - 1; 
      obj.k = obj.n - p; 
    end
    function ret = encode(obj, data)
      seq_length = diff([0 : obj.k : numel(data)]);  % Calcula o tamanho dos vetores a serem divididos
      seqs = mat2cell(data, 1, seq_length);      % Divide o vetor da mensagem original em subvetores com K elementos

      encDataInv = []; % Cria um vetor para armazenar os bits de saida do codificador
      for i = 1:length(seqs)
        tmp = encode(seqs{i}, obj.n, obj.k, 'hamming/binary'); % Codifica os dados usando a função Encode do Octave
        encDataInv = [encDataInv;tmp]; % Armazena os dados codificados em um array
      end
      
      ret = transpose(encDataInv); % Retorna o vetor transposto para mudar a dimensão da matriz de coluna pra linha
    end

    function ret = decode(obj, data)
      seq_length = diff([0 : obj.n : length(data)]);  % Calcula o tamanho dos vetores a serem divididos
      seqs = mat2cell(data, 1, seq_length);      % Divide o vetor da mensagem original em subvetores com K elementos

      decDataInv = []; % Cria um vetor para armazenar os bits de saida do codificador
      for j = 1:length(seqs)
        tmp = decode(seqs{j}, obj.n, obj.k, 'hamming/binary'); % Decodifica os dados usando a função Decode do Octave
        decDataInv = [decDataInv;tmp]; % Armazena os dados codificados em um array
      end
      
      ret = transpose(decDataInv);
    end
  end
end
