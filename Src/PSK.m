%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Classe: PSK %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Essa classe contempla o modulador e demodulador PSK

classdef PSK < handle
  properties
    M;
  end
  methods
    function obj = PSK(M)
      obj.M = M;
    end
    function ret = modulate(obj, data)
      ret = pskmod(data, obj.M);
    end
    function ret = demodulate(obj, data)
      ret = logical(pskdemod(data, obj.M));
    end
  end
end
