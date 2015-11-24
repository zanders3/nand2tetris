using System;
using System.IO;

public static class VMCompiler
{
	class VMWriter
	{
		public VMWriter(StreamWriter writer)
		{
			this.writer = writer;
		}

		string nextComment;
		readonly StreamWriter writer;
		public int LineNumber { get; private set; }
		public void Write(params string[] vals) 
		{ 
			writer.Write(vals[0]);
			if (nextComment != null)
			{
				writer.Write(" //");
				writer.Write(nextComment);
				nextComment = null;
			}
			writer.WriteLine();
			for (int i = 1; i<vals.Length; i++)
				writer.WriteLine(vals[i]);
			LineNumber += vals.Length; 
		}

		public void Comment(string comment)
		{
			nextComment = comment;
		}

		public void A(int val)
		{
			Write("@" + val);
		}

		public void DecSP()
		{
			Write("@SP", "M=M-1");
		}

		public void IncSP()
		{
			Write("@SP", "M=M+1");
		}
	}

	static string GetMemoryReg(VMCommand command)
	{
		switch (command.Arg1)
		{
			case "local":
				return "@LCL";
			case "argument":
				return "@ARG";
			case "this":
				return "@THIS";
			case "that":
				return "@THAT";
			default:
				throw new CompileException("Invalid target memory location: " + command.Arg1, command.LineIdx, command.Line);	
		}
	}

	public static void Compile(StreamReader streamReader, StreamWriter streamWriter, string fileName)
	{
		var writer = new VMWriter(streamWriter);
		writer.Write("@256 //stacksetup", "D=A", "@SP", "M=D");

		string currentFunctionName = null;

		foreach (VMCommand command in VMParser.Parse(streamReader))
		{
			writer.Comment(command.Line);
			switch (command.Command)
			{
				case VMCommand.CommandType.Push:
					command.Expect2Args();
					switch (command.Arg1)
					{
						case "constant":
							writer.A(command.Arg2.Value);
							writer.Write("D=A");
							break;
						case  "temp":
							if (command.Arg2 > 7 || command.Arg2 < 0)
								throw new CompileException("Temp out of range: " + command.Arg2, command.LineIdx, command.Line);

							writer.A(command.Arg2.Value + 5);
							writer.Write("D=M");
							break;
						case "pointer":
							if (command.Arg2 > 1 || command.Arg2 < 0)
								throw new CompileException("Pointer out of range: " + command.Arg2, command.LineIdx, command.Line);

							writer.Write(command.Arg2 == 0 ? "@THIS" : "@THAT");
							writer.Write("D=M");
							break;
						case "static":
							writer.Write("@" + fileName + "." + command.Arg2);
							writer.Write("D=M");
							break;
						default:
							writer.Write(GetMemoryReg(command), "D=M", "@" + command.Arg2, "A=D+A");
							writer.Write("D=M");
							break;
					}
					writer.Write("@SP", "A=M", "M=D");
                    writer.IncSP();
					break;
				case VMCommand.CommandType.Pop:
					command.Expect2Args();
					switch (command.Arg1)
					{
						case "temp":
							if (command.Arg2 > 7 || command.Arg2 < 0)
								throw new CompileException("Temp out of range: " + command.Arg2, command.LineIdx, command.Line);

							writer.Write("@SP", "M=M-1", "A=M", "D=M");
							writer.A(command.Arg2.Value + 5);
							writer.Write("M=D");
							break;	
						case "pointer":
							if (command.Arg2 > 1 || command.Arg2 < 0)
								throw new CompileException("Pointer out of range: " + command.Arg2, command.LineIdx, command.Line);

							writer.Write("@SP", "M=M-1", "A=M", "D=M");
							writer.Write(command.Arg2 == 0 ? "@THIS" : "@THAT");
							writer.Write("M=D");
							break;
						case "static":
							writer.Write("@SP", "M=M-1", "A=M", "D=M");
							writer.Write("@" + fileName + "." + command.Arg2);
							writer.Write("M=D");
							break;
						default:
							writer.Write(GetMemoryReg(command), "D=M", "@" + command.Arg2, "D=D+A", "@R13", "M=D");
							writer.Write("@SP", "M=M-1", "A=M", "D=M", "@R13", "A=M", "M=D");
							break;
					}
					break;
				case VMCommand.CommandType.Add:
				case VMCommand.CommandType.Sub:
				case VMCommand.CommandType.Or:
				case VMCommand.CommandType.And:
					writer.DecSP();
					writer.Write("A=M", "D=M");
					writer.DecSP();
					writer.Write("A=M", string.Format(
						"M=M{0}D",
						command.Command == VMCommand.CommandType.Add ? "+" : 
						command.Command == VMCommand.CommandType.Sub ? "-" :
						command.Command == VMCommand.CommandType.Or ? "|" :
						"&"
					));
					writer.IncSP();
					break;
				case VMCommand.CommandType.Eq:
				case VMCommand.CommandType.Lt:
				case VMCommand.CommandType.Gt:
					writer.DecSP();
					writer.Write("A=M", "D=M");
					writer.DecSP();
					writer.Write("A=M", "D=M-D", "M=-1");
					writer.A(writer.LineNumber+5);
					//D=A-B, SP=RESULT POS
					string jmpOp =
						command.Command == VMCommand.CommandType.Eq ? "JEQ" :
						command.Command == VMCommand.CommandType.Lt ? "JLT" :
						"JGT";
					writer.Write("D;" + jmpOp, "@SP", "A=M", "M=0");
					writer.IncSP();
					break;
				case VMCommand.CommandType.Neg:
				case VMCommand.CommandType.Not:
					command.ExpectNoArg();
					string bitOp = command.Command == VMCommand.CommandType.Neg ? "-" : "!";
					writer.DecSP();
					writer.Write("A=M",string.Format("M={0}M", bitOp));
					writer.IncSP();
					break;
				case VMCommand.CommandType.Label:
					command.ExpectArg();
					writer.Write("(" + currentFunctionName ?? fileName + "$" + command.Arg1 + ")");
					break;
				case VMCommand.CommandType.IfGoto:
					command.ExpectArg();
					writer.DecSP();
					writer.Write("A=M", "D=M", "@" + currentFunctionName ?? fileName + "$" + command.Arg1, "D;JGT");
					break;
				case VMCommand.CommandType.Goto:
					command.ExpectArg();
					writer.Write("@" + currentFunctionName ?? fileName + "$" + command.Arg1, "0;JMP");
					break;
				case VMCommand.CommandType.Function:
					command.Expect2Args();
					currentFunctionName = command.Arg1;
					command.Write("@" + command.Arg1);
					writer.Write("@SP");
					for (int i = 0; i<command.Arg2; i++) 
					{
						command.Write("A=M", "M=0", "A=A+1");
					}
					writer.Write("D=A", "@SP", "M=D");
					break;
				case VMCommand.CommandType.Return:
					command.ExpectNoArg();
					currentFunctionName = null;
					break;
				default:
					throw new CompileException("Unknown command: " + command.Command, command.LineIdx, command.Line);
			}
		}

		writer.Write("(INFLOOP)", "@INFLOOP", "0;JMP");
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
			using (var reader = new StreamReader(args[0]))
			{
				string targetPath = Path.Combine(
					Path.GetDirectoryName(args[0]), 
					Path.GetFileNameWithoutExtension(args[0]) + ".asm"
				);
				using (var writer = new StreamWriter(targetPath))
				{
					Compile(reader, writer, Path.GetFileNameWithoutExtension(targetPath));
				}
			}
		}
		catch (CompileException e)
		{
			Console.WriteLine(e.Message);
		}
	}
}