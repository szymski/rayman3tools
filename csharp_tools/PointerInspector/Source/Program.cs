using System;
using System.IO;
using System.Linq;
using System.Windows.Forms;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using PointerInspector.Source.Forms;

namespace PointerInspector.Source
{
    static class Program
    {
        public static JObject Settings { get; private set; }

        [STAThread]
        static void Main(string[] args)
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            LoadSettings();

            Application.Run(new MainForm(args.FirstOrDefault() ?? null));
        }

        static void LoadSettings()
        {
            if (!File.Exists("settings.json"))
            {
                MessageBox.Show("No settings found. Creating settings.json. Please configure this file.", "PointerInspector");
                CreateDefaultSettings();
            }

            Settings = JObject.Parse(File.ReadAllText("settings.json"));
        }

        static void CreateDefaultSettings()
        {
            Settings = new JObject();

            var paths = Settings["paths"] = new JObject();
            paths["rayman3lib"] = "./rayman3lib.exe";

            File.WriteAllText("settings.json", Settings.ToString());
        }
    }
}
