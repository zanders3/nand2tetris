using System;
using System.IO;

public static class VMCompiler
{
	class CompileException : Exception
	{
		public CompileException(string message, int lineIdx) : base(message + " on line " + lineIdx)
		{}
	}

	static void ExpectArgs(string[] args, int numArgs, int lineIdx)
	{
		if (args.Length != numArgs)
			throw new CompileException("Expected " + numArgs + " got " + args.Length, lineIdx);
	}

	public static void Compile(StreamReader reader, StreamWriter writer)
	{
		writer.WriteLine("@256 //stack setup\nD=A\n@SP\nM=D");
		int lineIdx = 1, outputLineIdx = 4;
		string line;
		while ((line = reader.ReadLine()) != null)
		{
			line = line.Trim();
			if (line.StartsWith("//") || line.Length == 0)
			{
				lineIdx++;
				continue;
			}
			string[] args = line.Split(' ');
			if (args.Length == 0)
				continue;
			switch (args[0])
			{
				case "push":
					ExpectArgs(args, 3, lineIdx);
					switch (args[1])
					{
						case "constant":
							int val;
							if (!int.TryParse(args[2], out val))
								throw new CompileException("Expected number not: " + args[2], lineIdx);
							writer.WriteLine("@{0} //{1}", args[2], line);
							writer.WriteLine("D=A\n@SP\nA=M\nM=D");
							outputLineIdx += 4;
							break;
						default:
							throw new CompileException("Invalid push type: " + args[1], lineIdx);
					}
					break;
				case "add":
				case "sub":
				case "or":
				case "and":
					ExpectArgs(args, 1, lineIdx);
					writer.WriteLine(
						"@SP //{0}\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nM=M{1}D",
						line,
						args[0] == "add" ? "+" : 
						args[0] == "sub" ? "-" :
						args[0] == "or"  ? "|" :
						"&"
					);
					outputLineIdx += 8;
					break;
				case "eq":
				case "lt":
				case "gt":
					ExpectArgs(args, 1, lineIdx);
					writer.WriteLine("@SP //{0}\nM=M-1\nA=M\nD=M\n@SP\nM=M-1\nA=M\nD=M-D", line);
					outputLineIdx += 8;
					//D=A-B, SP=RESULT POS
					string jmpOp =
						args[0] == "eq" ? "JEZ" :
						args[0] == "lt" ? "JLZ" :
						"JGZ";
					writer.WriteLine("M=1\n@LBL{1}\nD;{0}\n@SP\nM=0\n(LBL{1})", jmpOp, labelIdx++);
					outputLineIdx += 6;
					break;
				case "neg":
				case "not":
					ExpectArgs(args, 1, lineIdx);
					string bitOp = args[0] == "neg" ? "-" : "!";
					writer.WriteLine("@SP //{0}\nM=M-1\nA=M\nM={1}M", line, bitOp);
					outputLineIdx += 4;
					break;
				default:
					throw new CompileException("Unknown command: " + args[0], lineIdx);
			}
			writer.WriteLine("@SP\nM=M+1");
			lineIdx++;
		}
	}

	public static void Main(string[] args)
	{
		if (args.Length != 1 || !args[0].EndsWith(".vm"))
		{
			Console.WriteLine("Usage: Code.vm");
			return;
		}

		try
		{
			using (StreamReader reader = new StreamReader(args[0]))
			{
				string targetPath = Path.Combine(
					Path.GetDirectoryName(args[0]), 
					Path.GetFileNameWithoutExtension(args[0]) + ".asm"
				);
				using (StreamWriter writer = new StreamWriter(targetPath))
				{
					Compile(reader, writer);
				}
			}
		}
		catch (CompileException e)
		{
			Console.WriteLine(e.Message);
		}
	}
}