using System;
using System.Collections.Generic;
using System.IO;

public struct VMCommand
{
	public enum CommandType
	{
		Push,
		Pop,
		Add,
		Sub,
		Or,
		And,
		Eq,
		Lt,
		Gt,
		Neg,
		Not
	}

	public CommandType Command;
	public string Arg1;
	public int? Arg2;
	public string Line;
	public int LineIdx;

	public void Expect2Args()
	{
		if (!Arg2.HasValue)
			throw new CompileException("Expected two arguments", LineIdx);
	}

	public void ExpectArg()
	{
		if (!string.IsNullOrEmpty(Arg1))
			throw new CompileException("Expected one argument", LineIdx);
	}
}

class CompileException : Exception
{
	public CompileException(string message, int lineIdx) : base(message + " on line " + lineIdx)
	{}
}

public static class VMParser
{
	public static IEnumerable<VMCommand> Parse(StreamReader reader)
	{
		string line;
		for (int lineIdx = 1; (line = reader.ReadLine()) != null; lineIdx++)
		{
			line = line.Trim();
			if (line.StartsWith("//") || line.Length == 0)
				continue;
			string[] args = line.Split(' ');
			if (args.Length == 0)
				continue;

			VMCommand.CommandType type;
			if (!Enum.TryParse<VMCommand.CommandType>(args[0], true, out type))
				throw new CompileException("Unknown command: '" + args[0] + "'", lineIdx);
			int arg2 = 0;
			if (args.Length >= 3 && !int.TryParse(args[2], out arg2))
				throw new CompileException("Expected number: '" + args[2] + "'", lineIdx);

			yield return new VMCommand
			{
				Command = type,
				Arg1 = args.Length >= 2 ? args[1] : string.Empty,
				Arg2 = args.Length >= 3 ? arg2 : (int?)null,
				Line = line,
				LineIdx = lineIdx
			};
		}
	}
}