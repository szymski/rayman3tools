using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace PointerInspector.Source
{
    class Api
    {
        public struct Pointer
        {
            public int Address { get; set; }
            public int Value { get; set; }
        }

        public static Pointer[] GetPointers(string lvlFile, string ptrFile)
        {
            return GetPointersFromProcess(new Process
            {
                StartInfo = new ProcessStartInfo()
                {
                    FileName = (string)Program.Settings["paths"]["rayman3lib"],
                    RedirectStandardOutput = true,
                    RedirectStandardInput = true,
                    UseShellExecute = false,
                    Arguments = $"lvlrelocation \"{lvlFile}\" \"{ptrFile}\""
                }
            });
        }

        private static Pointer[] GetPointersFromProcess(Process process)
        {
            try
            {
                process.Start();
            }
            catch
            {
                MessageBox.Show("Please copy rayman3lib.exe to the current directory and restart the application.", "rayman3lib.exe not found", MessageBoxButtons.OK, MessageBoxIcon.Error);
                Application.Exit();
            }

            var pointers = new List<Pointer>();

            using (StreamReader reader = process.StandardOutput)
            {
                while (!process.HasExited)
                {
                    var result = reader.ReadLine().Split(' ');
                    pointers.Add(new Pointer()
                    {
                        Address = int.Parse(result[0]),
                        Value = int.Parse(result[1]),
                    });
                }
            }

            return pointers.ToArray();
        }

        public static byte[] DecodeBytes(byte[] bytes)
        {
            var stream = new MemoryStream(bytes);
            stream.Position = 4;

            byte[] decoded = new byte[bytes.Length];
            stream.Read(decoded, 4, bytes.Length - 4);

            return decoded;
        }
    }
}
