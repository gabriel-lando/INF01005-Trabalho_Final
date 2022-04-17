%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Classe: QAM %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Essa classe contempla o modulador e demodulador QAM

classdef QAM < handle
  properties
    M;
  end
  methods
    function obj = QAM(M)
      obj.M = M;
    end
    function ret = modulate(obj, data)
      ret = qammod(data, obj.M);
    end
    function ret = demodulate(obj, data)
      ret = logical(qamdemod(data, obj.M));
    end
  end
end
