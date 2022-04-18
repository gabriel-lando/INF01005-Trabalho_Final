using Newtonsoft.Json;
using OctaveSim;
using System.Diagnostics;

const string MainFileName = "Main.m";
const string ConfigsFileName = "Constants.m";
const string ProjectPath = @"C:\GitHub\INF01005-Trabalho_Final\Src";
const string OctavePath = @"C:\Program Files\GNU Octave\Octave-6.2.0\mingw64\bin\octave-cli.exe";
const int MaxThreads = 6;
const int WaitTimeSec = 5;
const bool PopOutSimShell = true;

var tasks = new List<Task>();
var semaphore = new Semaphore(MaxThreads, MaxThreads);

// Read and parse Configs JSON file
ConfigsFile configsFile;
using (StreamReader r = new("Configs.json"))
{
    string json = r.ReadToEnd();
    configsFile = JsonConvert.DeserializeObject<ConfigsFile>(json);
}

if (configsFile == null)
    return;

foreach (var pkt in configsFile.PktSizes)
    foreach (var mod in configsFile.Modulacao)
        foreach (var ebn0 in configsFile.EbN0dB)
        {
            Thread.Sleep(WaitTimeSec * 1000);

            int es = configsFile.Es_QAM.FirstOrDefault(kvp => kvp.Key == mod.ToString()).Value;
            var config = new Config(pkt, mod, es, ebn0);

            Task task = Task.Factory.StartNew(() => ThreadRunner(config));
            tasks.Add(task);
        }

Task.WaitAll(tasks.ToArray());


void ThreadRunner(Config config)
{
    semaphore.WaitOne();

    int num_bits = 200 * 1000; // Default number of bits is near to 200k
    int p = config.PktSize;
    int n = 0, k = 0;
    double r = 0;

    // Compute N, K and R values
    if (p != 0)
    {
        n = (int)Math.Pow(2, p) - 1;
        k = n - p;
        r = ((double)k) / n;
        num_bits = k * (num_bits / k);
    }

    int modulacao = config.Modulacao;
    string Eb_PSK = string.Format("1/({0}*{1})", Math.Log2(config.Modulacao), (r != 0) ? r : 1);
    string Eb_QAM = string.Format("{0}/({1}*{2})", config.Es_QAM, Math.Log2(config.Modulacao), (r != 0) ? r : 1);

    string Eb_N0_dB = config.EbN0dB;

    // Write these configs to the Configs file and run the simmulations
    string template = "pkt_size = {0};\nnum_bits = {1};\nmodulacao = {2};\nEb_N0_dB = {3};\nEb_PSK = {4};\nEb_QAM = {5};\n";
    string constants = string.Format(template, p, num_bits, modulacao, Eb_N0_dB, Eb_PSK, Eb_QAM);

    Console.WriteLine(string.Format("P: {0}, M: {1}, Eb/N0: {2}", p, modulacao, Eb_N0_dB));

    using (StreamWriter w = new(Path.Join(ProjectPath, ConfigsFileName)))
    {
        w.Write(constants);
        w.Flush();
    }

    var cmd = new Process();
    cmd.StartInfo.FileName = OctavePath;
    cmd.StartInfo.Arguments = MainFileName;
    cmd.StartInfo.WorkingDirectory = ProjectPath;
    cmd.StartInfo.UseShellExecute = PopOutSimShell;
    cmd.Start();
    cmd.WaitForExit();

    semaphore.Release();
}