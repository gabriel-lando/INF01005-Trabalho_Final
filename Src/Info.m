%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Classe: Info %%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Essa classe contempla a fonte e o receptor
% Fonte: a classe irá gerar um vetor de bits de acordo com parâmetro pré definido
%     Método: generateData()
%         -> retorna um vetor de bits pseudo-aleatório;
% Receptor: a classe irá comparar os bits recebidos pelo decodigicador com os bits gerados na fonte 
%     Método: getBER(dec_data);
%         -> Recebe um vetor de bits;
%         -> retorna o BER;

classdef Info < handle
  properties
    num_b;
    data;
  end
  methods
    function obj = Info(num_b)
      obj.num_b = num_b;
      obj.data = [];
    end
    function ret = generateData(obj)
      obj.data = randi(2, 1, obj.num_b) - 1; % Gera um vetor de dados binários aleatórios
      ret = obj.data;
    end
    function ret = getBER(obj, dec_data)
      ret = sum(obj.data ~= dec_data) / obj.num_b; % Contagem de erros e cálculo do BER
    end
  end
end
