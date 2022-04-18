using Newtonsoft.Json.Serialization;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OctaveSim
{
    public class ConfigsFile
    {
        public List<int> PktSizes { get; set; } = new List<int>();
        public List<int> Modulacao { get; set; } = new List<int>();
        public List<string> EbN0dB { get; set; } = new List<string>();
        public Dictionary<string, int> Es_QAM { get; set; } = new Dictionary<string, int>();
    }

    public class Config
    {
        public Config(int pkt, int mod, int es, string ebn0)
        {
            PktSize = pkt;
            Modulacao = mod;
            Es_QAM = es;
            EbN0dB = ebn0;
        }

        public int PktSize { get; set; }
        public int Modulacao { get; set; }
        public int Es_QAM { get; set; }
        public string EbN0dB { get; set; } = string.Empty;
    }
}
