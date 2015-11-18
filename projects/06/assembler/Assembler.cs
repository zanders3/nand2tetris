using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;

public static class Assembler
{
	class ParseException : Exception
	{
		public ParseException(string message) : base(message)
		{
		}
	}

	static void Assemble(StreamWriter writer, List<string> lines)
	{
		Dictionary<string, int> symbolTable = new Dictionary<string, int>
		{
			{ "SP", 0 },
			{ "LCL", 1 },
			{ "ARG", 2 },
			{ "THIS", 3 },
			{ "SCREEN", 16384 },
			{ "KBD", 24576 }
		};
		for (int i = 0; i<15; i++)
		{
			symbolTable["R" + i] = i;
		}
		Dictionary<string, int> labelTable = new Dictionary<string, int>();

		//First allocate symbol and line tables
		int lineIdx = 0, lineCount = 0, symbolIdx = 15;
		foreach (string line in lines)
		{
			if (line.Length <= 1)
				continue;
			if (line[0] == '@' && char.IsLetter(line[1]))
			{
				string symbol = line.Substring(1);
				if (!symbolTable.ContainsKey(symbol))
				{
					symbolTable[symbol] = symbolIdx++;
				}
				lineCount++;
			}
			else if (line[0] == '(' && line[line.Length-1] == ')')
			{
				string label = line.Substring(1,line.Length-2);
				if (labelTable.ContainsKey(label))
					throw new ParseException("Duplicate label name: " + label + " on line " + lineIdx);
				labelTable[label] = lineCount;
			}
			else
				lineCount++;
			lineIdx++;
		}

		//Process into assembly
		lineIdx = 0;
		foreach (string line in lines)
		{
			if (line.Length <= 1 || line[0] == '(')
				continue;
			int val;
			if (line[0] == '@')
			{
				string lineVal = line.Substring(1);
				if (char.IsDigit(line[1]))
					val = int.Parse(lineVal);
				else if (labelTable.ContainsKey(lineVal))
					val = labelTable[lineVal];
				else if (symbolTable.ContainsKey(lineVal))
					val = symbolTable[lineVal];
				else
					throw new ParseException("Unexpected symbol: " + lineVal + " at line " + lineIdx);
			}
			else
			{
				val = (1 << 15 | 1 << 14 | 1 << 13);
				string aluPart = string.Empty, destPart = string.Empty, jumpPart = string.Empty;
				{
					string[] bits = line.Split(';');
					if (bits.Length == 0)
						throw new ParseException("Unexpected empty command at line " + lineIdx);
					if (bits.Length > 1)
						jumpPart = bits[1];
					bits = bits[0].Split('=');
					if (bits.Length == 1)
					{
						destPart = string.Empty;
						aluPart = bits[0];
					}
					else if (bits.Length == 2)
					{
						destPart = bits[0];
						aluPart = bits[1];
					}
					else
						throw new ParseException("Syntax error at line " + lineIdx);
				}

				foreach (char c in destPart)
				{
					switch (c)
					{
						case 'A':
							val |= (1 << 5);
							break;
						case 'D':
							val |= (1 << 4);
							break;
						case 'M':
							val |= (1 << 3);
							break;
						case '0':
							//val |= 0
							break;
						default:
							throw new ParseException("Unknown destination: '" + c + "'' in '" + destPart + "' on line " + lineIdx);
					}
				}

				switch (jumpPart)
				{
					case "":
						break;
					case "JGT":
						val |= 1;
						break;
					case "JEQ":
						val |= 2;
						break;
					case "JGE":
						val |= 3;
						break;
					case "JLT":
						val |= 4;
						break;
					case "JNE":
						val |= 5;
						break;
					case "JLE":
						val |= 6;
						break;
					case "JMP":
						val |= 7;
						break;
					default:
						throw new ParseException("Unknown jump condition: '" + jumpPart + "' on line " + lineIdx);
				}

				if (aluPart.Contains("M"))
					val |= (1 << 12);

				switch (aluPart)
				{
					case "":
						break;
					case "0":
						val |= 2688;
						break;
					case "1":
						val |= 4032;
						break;
					case "-1":
						val |= 3712;
						break;
					case "D":
						val |= 768;
						break;
					case "A":
					case "M":
						val |= 3072;
						break;
					case "!D":
						val |= 832;
						break;
					case "!A":
					case "!M":
						val |= 3136;
						break;
					case "-D":
						val |= 960;
						break;
					case "-A":
					case "-M":
						val |= 3264;
						break;
					case "D+1":
						val |= 1984;
						break;
					case "A+1":
					case "M+1":
						val |= 3520;
						break;
					case "D-1":
						val |= 896;
						break;
					case "A-1":
					case "M-1":
						val |= 3200;
						break;
					case "D+A":
					case "D+M":
						val |= 128;
						break;
					case "D-A":
					case "D-M":
						val |= 1216;
						break;
					case "A-D":
					case "M-D":
						val |= 448;
						break;
					case "D&A":
					case "D&M":
						//val |= 0;
						break;
					case "D|A":
					case "D|M":
						val |= 1344;
						break;
					default:
						throw new ParseException("Unknown ALU expression: '" + aluPart + "' on line " + lineIdx);
				}
			}
			string strVal = Convert.ToString(val, 2);
			string finalLine = new string('0', 16 - strVal.Length) + strVal;
			writer.WriteLine(finalLine);
			Console.WriteLine(line);
			Console.WriteLine(finalLine);

			lineIdx++;
		}
	}

	public static void Main(string[] args)
	{
		if (args.Length != 1 && !args[0].EndsWith(".asm"))
		{
			Console.WriteLine("Usage: Prog.asm");
			return;
		}

		try
		{
			using (var writer = new StreamWriter(Path.Combine(Path.GetDirectoryName(args[0]), Path.GetFileNameWithoutExtension(args[0]) + ".hack")))
			{
				List<string> lines = File.ReadAllLines(args[0]).Select(line =>
				{
					string l = line.Trim();
					int ind = l.IndexOf("//");
					if (ind != -1)
						l = l.Substring(0,ind).Trim();
					return l;
				}).ToList();

				Assemble(writer, lines);
			}
		}	
		catch (ParseException e)
		{
			Console.WriteLine(e.Message);
		}
	}
}
